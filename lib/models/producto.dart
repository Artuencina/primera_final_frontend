//Modelo de productos

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Producto {
  String id;
  String nombreProducto;
  String idCategoria;
  double precio;

  Producto(
      {required this.nombreProducto,
      required this.idCategoria,
      required this.precio})
      : id = uuid.v4();
}
