//Modelo de venta
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Venta {
  String id;
  String numeroFactura;
  DateTime fecha;
  List<VentaDetalle> ventaDetalle;
  double total;

  Venta(
      {required this.numeroFactura,
      required this.fecha,
      required this.ventaDetalle,
      required this.total})
      : id = uuid.v4();
}

class VentaDetalle {
  String idVenta;
  String idProducto;
  int cantidad;

  VentaDetalle(
      {required this.idVenta,
      required this.idProducto,
      required this.cantidad});
}