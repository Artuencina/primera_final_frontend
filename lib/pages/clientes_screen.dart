import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_productos/models/cliente.dart';
import 'package:registro_productos/provider/clientes_provider.dart';
import 'package:registro_productos/widgets/cliente_item.dart';
import 'package:registro_productos/widgets/sidescreen.dart';

class ClientesScreen extends ConsumerStatefulWidget {
  const ClientesScreen({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  ConsumerState<ClientesScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends ConsumerState<ClientesScreen> {
  void _addPaciente(Cliente cliente) {
    setState(() {
      //Agregar persona al estado
      ref.read(clientesProvider.notifier).addCliente(cliente);
    });

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        showCloseIcon: true,
        content: Text('Cliente agregado'),
      ),
    );
  }

  void _updateCliente(Cliente newCliente) {
    setState(() {
      ref.read(clientesProvider.notifier).updateCliente(newCliente);
    });

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        showCloseIcon: true,
        content: Text('Cliente actualizado'),
      ),
    );
  }

  void _deleteCliente(Cliente cliente) {
    final index = ref.read(clientesProvider).indexOf(cliente);

    setState(() {
      //Eliminar cliente
      ref.read(clientesProvider.notifier).removeCliente(cliente);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Cliente eliminado'),
        action: SnackBarAction(
          label: "Deshacer",
          onPressed: () {
            setState(() {
              ref.read(clientesProvider.notifier).insertCliente(index, cliente);
            });
          },
        ),
      ),
    );
  }

  bool validarEmail(String email) {
    final RegExp regex = RegExp(
      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return regex.hasMatch(email);
  }

  // Modal para agregar y editar personas
  void _showModalCliente(Cliente? editCliente) {
    TextEditingController nombreController = TextEditingController(
      text: editCliente != null ? editCliente.nombre : "",
    );
    TextEditingController apellidoController = TextEditingController(
      text: editCliente != null ? editCliente.apellido : "",
    );
    TextEditingController emailController = TextEditingController(
      text: editCliente != null ? editCliente.email : "",
    );
    TextEditingController rucController = TextEditingController(
      text: editCliente != null ? editCliente.ruc : "",
    );

    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,

      //Modal
      builder: (context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(editCliente != null
                ? "Editar cliente"
                : "Agregar cliente"),
            const SizedBox(height: 20),
            TextField(
              controller: nombreController,
              //Aca se ponen todas las cuestiones de estilo
              //del input
              decoration: const InputDecoration(
                labelText: "Nombre",
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: apellidoController,
              decoration: const InputDecoration(
                labelText: "Apellido",
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              controller: rucController,
              decoration: const InputDecoration(
                labelText: "Ruc",
                icon: Icon(Icons.credit_card),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                icon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  //Metodo para agregar o editar la categoria

                  onPressed: () {
                    if (editCliente != null) {
                      editCliente.nombre = nombreController.text;
                      editCliente.apellido = apellidoController.text;
                      editCliente.email = emailController.text;
                      editCliente.ruc = rucController.text;
                      _updateCliente(editCliente);
                    } else {
                      _addPaciente(
                        Cliente(
                          nombre: nombreController.text,
                          apellido: apellidoController.text,
                          email: emailController.text,
                          ruc: rucController.text,
                        ),
                      );
                    }
                  },
                  child: Text(editCliente != null ? 'Editar' : 'Agregar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
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
    final clientes = ref.watch(clientesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de clientes"),
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
      ),
      drawer: const SideBar(),
      body: clientes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people,
                    size: 100,
                    color: widget.color
                  ),
                  const SizedBox(height: 10),
                  const Text("No hay clientes"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                return ClienteItem(
                  icon: Icons.person,
                  color: widget.color,
                  cliente: clientes[index],
                  deleteCliente: _deleteCliente,
                  updateCliente: _showModalCliente,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalCliente(null);
        },
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}