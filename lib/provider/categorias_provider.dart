//Riverpod statenotifier para categorias

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_productos/models/categoria.dart';

class CategoriasProvider extends StateNotifier<List<Categoria>> {
  CategoriasProvider() : super([]);

  void addCategoria(Categoria categoria) {
    state = [...state, categoria];
  }

  void removeCategoria(Categoria categoria) {
    state = state.where((element) => element != categoria).toList();
  }
}

final categoriasProvider =
    StateNotifierProvider<CategoriasProvider, List<Categoria>>(
  (ref) => CategoriasProvider(),
);
