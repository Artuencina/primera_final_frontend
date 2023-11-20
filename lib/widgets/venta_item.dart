import 'package:flutter/material.dart';
import 'package:registro_productos/models/venta.dart';
import 'package:registro_productos/models/cliente.dart';

class VentaItem extends StatelessWidget {
  const VentaItem({
    Key? key,
    required this.venta,
    required this.clientes,
    required this.onDelete,
  }) : super(key: key);

  final Venta venta;
  final List<Cliente> clientes;
  final Function(Venta) onDelete;

  @override
  Widget build(BuildContext context) {
    final Cliente? cliente = Cliente.getClientById(clientes, venta.idCliente);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          'Factura ${venta.numeroFactura}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Cliente: ${cliente?.nombre ?? 'No encontrado'}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Fecha: ${venta.fecha.toLocal()}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Total: \$${venta.total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => onDelete(venta),
        ),
      ),
    );
  }
}
