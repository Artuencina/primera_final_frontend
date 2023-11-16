//Provider para productos
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_productos/models/producto.dart';

class ProductosProvider extends StateNotifier<List<Producto>> {
  ProductosProvider() : super([]);

  void addProducto(Producto producto) {
    state = [...state, producto];
  }

  void removeProducto(Producto producto) {
    state = state.where((element) => element != producto).toList();
  }
}

final productosProvider =
    StateNotifierProvider<ProductosProvider, List<Producto>>(
  (ref) => ProductosProvider(),
);
