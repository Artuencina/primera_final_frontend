//Modal para buscar productos a partir del nombre
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_productos/provider/productos_provider.dart';

class SearchProducto extends ConsumerStatefulWidget {
  const SearchProducto({super.key});

  @override
  ConsumerState<SearchProducto> createState() => _SearchProductoState();
}

class _SearchProductoState extends ConsumerState<SearchProducto> {
  final nombreController = TextEditingController();

  //Buscador superior y listview de productos
  @override
  Widget build(BuildContext context) {
    final productos = ref.watch(productosProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Producto'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                hintText: 'Buscar producto',
                suffixIcon: Icon(Icons.search),
              ),
              //Al cambiar, buscamos el producto del provider
              onChanged: (value) {
                ref.read(productosProvider.notifier).buscarProducto(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return ListTile(
                  title: Text(producto.nombreProducto),
                  subtitle: Text(producto.precio.toString()),
                  onTap: () {
                    //Al seleccionar el producto, lo agregamos a la venta
                    Navigator.of(context).pop(producto);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
