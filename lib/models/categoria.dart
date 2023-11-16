//Modelo de productos
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Categoria {
  String id;
  String nombre;

  Categoria({required this.nombre}) : id = uuid.v4();
}
