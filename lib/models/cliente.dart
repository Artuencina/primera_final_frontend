//Modelo de clientes

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Cliente {
  String id;
  String nombre;
  String apellido;
  String? ruc;
  String? email;

  Cliente({required this.nombre, required this.apellido, this.ruc, this.email})
      : id = uuid.v4();
}
