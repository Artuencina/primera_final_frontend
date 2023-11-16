import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registro_productos/routes.dart';

//Tema principal
final kTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigoAccent,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.indigo,
    centerTitle: true,
    elevation: 5,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(MaterialApp.router(
    theme: kTheme,
    routerConfig: router,
    title: 'Registro de Productos',
    themeMode: ThemeMode.light,
  ));
}
