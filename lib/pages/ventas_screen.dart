//Vista de ventas
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_productos/widgets/sidescreen.dart';
import 'package:registro_productos/models/cliente.dart';
import 'package:registro_productos/models/venta.dart';
import 'package:registro_productos/provider/ventas_provider.dart';
import 'package:registro_productos/provider/clientes_provider.dart';
import 'package:registro_productos/widgets/venta_item.dart';

class VentasScreen extends ConsumerWidget {
  const VentasScreen({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ventas = ref.watch(ventasProvider);
    final clientes = ref.watch(clientesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de ventas"),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      drawer: const SideBar(),
      body: ventas.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: color,
                  ),
                  const SizedBox(height: 10),
                  const Text("No hay ventas"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: ventas.length,
              itemBuilder: (context, index) {
                return VentaItem(
                  venta: ventas[index],
                  clientes: clientes,
                  onDelete: (venta) {
                    ref.read(ventasProvider.notifier).removeVenta(venta);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalVenta(context, ref, clientes);
        },
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showModalVenta(
      BuildContext context, WidgetRef ref, List<Cliente> clientes) {
    TextEditingController numeroFacturaController = TextEditingController();
    TextEditingController totalController = TextEditingController();
    Cliente? selectedCliente;

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
            const Text("Agregar venta"),
            const SizedBox(height: 20),
            DropdownButtonFormField<Cliente>(
              value: selectedCliente,
              onChanged: (Cliente? newValue) {
                selectedCliente = newValue;
              },
              items: clientes
                  .map((cliente) => DropdownMenuItem<Cliente>(
                        value: cliente,
                        child: Text(cliente.nombre),
                      ))
                  .toList(),
              decoration: const InputDecoration(
                labelText: "Cliente",
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedCliente != null) {
                  final nuevaVenta = Venta(
                    numeroFactura: numeroFacturaController.text,
                    fecha: DateTime.now(),
                    ventaDetalle: [], 
                    total: double.parse(totalController.text),
                    idCliente: selectedCliente!.id,
                  );

                  ref.read(ventasProvider.notifier).addVenta(nuevaVenta);

                  Navigator.of(context).pop(); 

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      showCloseIcon: true,
                      content: Text('Venta agregada'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      showCloseIcon: true,
                      content: Text('Seleccione un cliente'),
                    ),
                  );
                }
              },
              child: const Text('Agregar'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
