//Provider para clientes

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_productos/models/cliente.dart';

class ClientesProvider extends StateNotifier<List<Cliente>> {
  ClientesProvider() : super([]);

  void addCliente(Cliente cliente) {
    state = [...state, cliente];
  }

  void removeCliente(Cliente cliente) {
    state = state.where((element) => element != cliente).toList();
  }

  void insertCliente(int index, Cliente cliente) {
    //Si el index es mayor al tamaño de la lista
    //insertar al final
    if (index >= state.length) {
      state = [...state, cliente];
      return;
    }

    state = [...state.sublist(0, index), cliente, ...state.sublist(index)];
  }

  void updateCliente(Cliente cliente) {
    state = [
      for (final item in state)
        if (item.id == cliente.id) cliente else item
    ];
  }
}

final clientesProvider = StateNotifierProvider<ClientesProvider, List<Cliente>>(
  (ref) => ClientesProvider(),
);
