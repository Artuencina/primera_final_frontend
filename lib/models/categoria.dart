//Modelo de productos
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Categoria {
  String id;
  String nombre;

  Categoria({required this.nombre}) : id = uuid.v4();

  static Categoria? getCategoriaById(List<Categoria> categorias, String id) {
    return categorias.firstWhere((categoria) => categoria.id == id);
  }
}
