import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registro_productos/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Tema principal
final kTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
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
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: kTheme,
        initialRoute: '/ventas',
        title: 'Registro de Productos',
        themeMode: ThemeMode.light,
        routes: routes,
      ),
    ),
  );
}
