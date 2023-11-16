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
}

final clientesProvider = StateNotifierProvider<ClientesProvider, List<Cliente>>(
  (ref) => ClientesProvider(),
);
