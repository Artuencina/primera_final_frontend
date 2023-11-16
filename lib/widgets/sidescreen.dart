//Sidebar que muestra todas las vistas

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text('Registro de productos',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Ventas'),
            onTap: () {
              context.go('/ventas');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Clientes'),
            onTap: () {
              context.go('/clientes');
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Productos'),
            onTap: () {
              Navigator.pushNamed(context, '/productos');
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categorías'),
            onTap: () {
              Navigator.pushNamed(context, '/categorias');
            },
          )
        ],
      ),
    );
  }
}
