// widgets/producto_item.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registro_productos/models/producto.dart';
import 'package:registro_productos/models/categoria.dart';

class ProductoItem extends StatelessWidget {
  const ProductoItem({
    Key? key,
    required this.producto,
    required this.categorias,
    required this.onDelete,
  }) : super(key: key); 

  final Producto producto;
  final List<Categoria> categorias;
  final Function(Producto) onDelete;

  @override
  Widget build(BuildContext context) {
    // Buscar la categoría por ID
    final Categoria? categoria = Categoria.getCategoriaById(categorias, producto.idCategoria);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          producto.nombreProducto,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Categoría: ${categoria?.nombre ?? 'No encontrada'}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Precio: ${NumberFormat('#,###', 'es_PY').format(producto.precio.toInt())} Gs.',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => onDelete(producto),
        ),
      ),
    );
  }
}
