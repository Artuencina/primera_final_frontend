//Pantalla basica solamente para mostrar el pdf
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:registro_productos/models/venta.dart';
import 'package:registro_productos/provider/pdfexport.dart';

class PdfPreviewScreen extends StatelessWidget {
  const PdfPreviewScreen({super.key, required this.venta});

  final Venta venta;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDF'),
        ),
        body: PdfPreview(
          canDebug: false,
          canChangeOrientation: false,
          build: (context) => makePdf(venta),
        ));
  }
}
