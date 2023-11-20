import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:registro_productos/models/venta.dart';

Widget paddedText(
  final String text, {
  final TextAlign textAlign = TextAlign.left,
}) =>
    Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11),
        textAlign: textAlign,
      ),
    );

makePdf(Venta venta) async {
  final pdf = Document(
    title: 'Fichas',
  );

  pdf.addPage(Page(
    pageFormat: PdfPageFormat.a4,
    orientation: PageOrientation.portrait,
    build: (context) {
      return Column(children: [
        Text(
          'Venta de productos N° ${venta.numeroFactura}',
          style: const TextStyle(fontSize: 24),
        ),

        //Fecha
        paddedText(
            'Fecha: ${venta.fecha.day}/${venta.fecha.month}/${venta.fecha.year}'),

        //Cliente
        paddedText(
            'Cliente: ${venta.cliente.nombre} ${venta.cliente.apellido}'),

        //Ruc
        paddedText('Ruc: ${venta.cliente.ruc}'),

        //Email
        paddedText('Email: ${venta.cliente.email}'),

        //Espaciado
        SizedBox(height: 20),

        //Table con el detalle de la venta
        Expanded(
          child: Table(
            border: TableBorder.all(
              color: PdfColors.black,
            ),
            children: [
              //Headers
              TableRow(
                children: [
                  paddedText('Producto'),
                  paddedText('Cantidad'),
                  paddedText('Precio'),
                  paddedText('Subtotal'),
                ],
              ),

              //Detalle de la venta
              for (final detalle in venta.ventaDetalle)
                TableRow(
                  children: [
                    paddedText(detalle.producto.nombreProducto),
                    paddedText(detalle.cantidad.toString()),
                    paddedText(detalle.producto.precio.toString()),
                    paddedText((detalle.producto.precio).toString()),
                  ],
                ),

              //Mostrar la cantidad total de fichas
              TableRow(
                children: [
                  paddedText('Total: ${venta.total}'),
                ],
              ),
            ],
          ),
        ),

        //Al fondo de la pagina, poner agradecimentos en texto
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            'Gracias por confiar en nosotros',
            textAlign: TextAlign.center,
          ),
        ),
      ]);
    },
  ));

  return pdf.save();
}
