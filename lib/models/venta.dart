import 'package:registro_productos/models/cliente.dart';
import 'package:registro_productos/models/producto.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Venta {
  String id;
  Cliente cliente;
  String numeroFactura;
  DateTime fecha;
  List<VentaDetalle> ventaDetalle;
  double total;

  Venta(
      {required this.numeroFactura,
      required this.fecha,
      required this.cliente,
      required this.ventaDetalle,
      required this.total})
      : id = uuid.v4();
}

class VentaDetalle {
  String? idVenta;
  Producto producto;
  int cantidad;

  VentaDetalle({this.idVenta, required this.producto, required this.cantidad});
}
