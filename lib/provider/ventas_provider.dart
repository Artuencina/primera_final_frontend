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

  void get ultimaVenta {
    if (state.isEmpty) {
      return;
    }
    state.last;
  }

  //Obtener el string para la siguiente factura
  String get nuevaFactura {
    if (state.isEmpty) {
      return '0010010000001';
    }

    final ultimaFactura = state.last.numeroFactura;

    //Separamos los ultimos 7 digitos y aumentamos en uno
    //Luego rellenamos los 7 con padleft y unimos a la factura
    final ultimos = ultimaFactura.substring(6, 13);
    final numero = int.parse(ultimos) + 1;
    final nuevo = numero.toString().padLeft(7, '0');
    return '001001$nuevo';
  }
}

final ventasProvider = StateNotifierProvider<VentasProvider, List<Venta>>(
  (ref) => VentasProvider(),
);
