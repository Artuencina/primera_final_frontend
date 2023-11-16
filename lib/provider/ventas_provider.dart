//Provider para las ventas y ventasdetalle

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_productos/models/venta.dart';

class VentasProvider extends StateNotifier<List<Venta>> {
  VentasProvider() : super([]);

  void addVenta(Venta venta) {
    state = [...state, venta];
  }

  void removeVenta(Venta venta) {
    state = state.where((element) => element != venta).toList();
  }
}

final ventasProvider = StateNotifierProvider<VentasProvider, List<Venta>>(
  (ref) => VentasProvider(),
);
