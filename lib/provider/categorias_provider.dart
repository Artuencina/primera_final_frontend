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
   
  void insertCategoria(int index, Categoria categoria) {
    state = [...state.sublist(0, index), categoria, ...state.sublist(index)];
  }

  void updateCategoria(Categoria categoria) {
    state = [
      for (final item in state)
        if (item.id == categoria.id) categoria else item
    ];
  }
}

final categoriasProvider =
    StateNotifierProvider<CategoriasProvider, List<Categoria>>(
  (ref) => CategoriasProvider(),
);
