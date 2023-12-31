import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_productos/models/categoria.dart';
import 'package:registro_productos/provider/categorias_provider.dart';
import 'package:registro_productos/widgets/category_item.dart';
import 'package:registro_productos/widgets/sidescreen.dart';

class CategoriasScreen extends ConsumerStatefulWidget {
  const CategoriasScreen({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  ConsumerState<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends ConsumerState<CategoriasScreen> {
  //Mostrar mensaje para deshacer la eliminacion de una categoria
  void _removeCategoria(Categoria categoria, int index) {
    //Eliminar categoria
    ref.read(categoriasProvider.notifier).removeCategoria(categoria);
    //Mostrar mensaje de deshacer
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Categoria eliminada'),
        action: SnackBarAction(
          label: "Deshacer",
          onPressed: () {
            ref
                .read(categoriasProvider.notifier)
                .insertCategoria(index, categoria);
          },
        ),
      ),
    );
  }

  //Metodo para agregar una categoria
  void _showModalCategoria(Categoria? editCategoria) {
    //Controller para manejar el texto del input
    TextEditingController descripcionController =
        TextEditingController(text: editCategoria?.nombre);

    //Mostrar modal para agregar categoria
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,

      //Modal
      builder: (context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            editCategoria != null
                ? const Text('Editar categoria')
                : const Text("Agregar categoría"),
            const SizedBox(height: 20),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripcion',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  //Metodo para agregar o editar la categoria

                  onPressed: () {
                    if (editCategoria != null) {
                      editCategoria.nombre = descripcionController.text;
                      ref
                          .read(categoriasProvider.notifier)
                          .updateCategoria(editCategoria);

                      //Volver a la pantalla anterior
                      Navigator.of(context).pop();

                      //Mostrar mensaje
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        showCloseIcon: true,
                        content: Text('Categoria actualizada'),
                      ));
                    } else {
                      ref.read(categoriasProvider.notifier).addCategoria(
                            Categoria(
                              nombre: descripcionController.text,
                            ),
                          );
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        showCloseIcon: true,
                        content: Text('Categoria agregada'),
                      ));
                    }
                  },
                  child: Text(editCategoria != null ? 'Editar' : 'Agregar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  //Cerrar modal

                  onPressed: Navigator.of(context).pop,
                  child: const Text('Cancelar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Obtener lista de categorias
    final categorias = ref.watch(categoriasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Categorias"),
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
      ),
      drawer: const SideBar(),
      body: categorias.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text("No hay categorías"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                return CategoryItem(
                  color: widget.color,
                  categoria: categorias[index],
                  onUpdate: _showModalCategoria,
                  onDelete: _removeCategoria,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalCategoria(null);
        },
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
