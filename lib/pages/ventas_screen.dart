//Vista de ventas
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_productos/widgets/sidescreen.dart';

class VentasScreen extends ConsumerWidget {
  const VentasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppbar(context),
      drawer: const SideBar(),
      body: _buildBody(ref),
    );
  }
}

_buildAppbar(BuildContext context) {
  //Mostrar el appbar con una accion para agregar una nueva venta
  return AppBar(
    title: const Text('Ventas'),
    actions: [
      //Agregar una nueva venta
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Scaffold(),
            ),
          );
        },
      )
    ],
  );
}

_buildBody(WidgetRef ref) {
  //Mostrar el cuerpo de la vista
  //A partir del provider de ventas
  //Con un ListView
  return const Center(
    child: Text('Ventas'),
  );
}
