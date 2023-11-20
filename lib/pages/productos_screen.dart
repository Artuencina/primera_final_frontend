import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_productos/models/producto.dart';
import 'package:registro_productos/models/categoria.dart';
import 'package:registro_productos/provider/productos_provider.dart';
import 'package:registro_productos/provider/categorias_provider.dart';
import 'package:registro_productos/widgets/producto_item.dart';
import 'package:registro_productos/widgets/sidescreen.dart';

class ProductosScreen extends ConsumerWidget {
  const ProductosScreen({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productos = ref.watch(productosProvider);
    final categorias = ref.watch(categoriasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de productos"),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      drawer: const SideBar(),
      body: productos.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_basket,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text("No hay productos"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                return ProductoItem(
                  producto: productos[index],
                  categorias: categorias,
                  onDelete: (producto) {
                    ref
                        .read(productosProvider.notifier)
                        .removeProducto(producto);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalProducto(context, ref, categorias);
        },
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showModalProducto(
      BuildContext context, WidgetRef ref, List<Categoria> categorias) {
    TextEditingController nombreController = TextEditingController();
    Categoria? selectedCategoria;
    TextEditingController precioController = TextEditingController();

    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Agregar producto"),
            const SizedBox(height: 20),
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: "Nombre del producto",
                icon: Icon(Icons.shopping_cart),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<Categoria>(
              value: selectedCategoria,
              onChanged: (Categoria? newValue) {
                selectedCategoria = newValue;
              },
              items: categorias
                  .map((categoria) => DropdownMenuItem<Categoria>(
                        value: categoria,
                        child: Text(categoria.nombre),
                      ))
                  .toList(),
              decoration: const InputDecoration(
                labelText: "Categoría",
                icon: Icon(Icons.category),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: precioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Precio de venta",
                icon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedCategoria != null) {
                  final nuevoProducto = Producto(
                    nombreProducto: nombreController.text,
                    idCategoria: selectedCategoria!.id,
                    precio: double.parse(precioController.text),
                  );

                  ref
                      .read(productosProvider.notifier)
                      .addProducto(nuevoProducto);

                  Navigator.of(context).pop(); // Cerrar modal

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      showCloseIcon: true,
                      content: Text('Producto agregado'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      showCloseIcon: true,
                      content: Text('Seleccione una categoría'),
                    ),
                  );
                }
              },
              child: const Text('Agregar'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar modal
              },
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
