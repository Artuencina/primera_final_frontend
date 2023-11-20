//Sidebar que muestra todas las vistas

import 'package:flutter/material.dart';

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
              color: Colors.indigo,
              child: Center(
                child: Text('Registro de productos',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                        )),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Ventas'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/ventas');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Clientes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/clientes');
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Productos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/productos');
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categorías'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/categorias');
            },
          )
        ],
      ),
    );
  }
}
