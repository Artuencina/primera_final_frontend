//Vista de ventas
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:registro_productos/models/venta.dart';
import 'package:registro_productos/provider/ventas_provider.dart';
import 'package:registro_productos/widgets/modal_venta.dart';
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
      appBar: _buildAppbar(context, ref),
      drawer: const SideBar(),
      body: _buildBody(ref),
    );
  }
}

_buildAppbar(BuildContext context, WidgetRef ref) {
  //Mostrar el appbar con una accion para agregar una nueva venta
  return AppBar(
    title: const Text('Ventas'),
    actions: [
      //Agregar una nueva venta
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () async {
          final venta = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ModalVenta(),
            ),
          );

          //Si la venta no es null, guardar
          if (venta != null) {
            ref.read(ventasProvider.notifier).addVenta(venta);
          }
        },
      )
    ],
  );
}

_buildBody(WidgetRef ref) {
  //Mostrar el cuerpo de la vista
  //A partir del provider de ventas
  //Con un ListView

  final ventas = ref.watch(ventasProvider);
  return ventas.isEmpty ? _buildEmpty() : _buildList(ventas, ref);
}

_buildEmpty() {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shopping_cart_outlined,
          size: 100,
          color: Colors.grey,
        ),
        SizedBox(height: 20),
        Text(
          'No hay ventas registradas',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}

_buildList(List<Venta> ventas, WidgetRef ref) {
  return ListView.builder(
    itemCount: ventas.length,
    itemBuilder: (context, index) {
      final venta = ventas[index];
      return Dismissible(
        key: ValueKey(venta.id),
        background: Container(
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          //Borrar venta del provider
          ref.read(ventasProvider.notifier).removeVenta(venta);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black54),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text(venta.numeroFactura),
            subtitle: Text(DateFormat.yMMMd().format(venta.fecha)),
            trailing: Text(venta.total.toString()),
          ),
        ),
      );
    },
  );
}
