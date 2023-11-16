import 'package:go_router/go_router.dart';
import 'package:registro_productos/pages/categorias_screen.dart';
import 'package:registro_productos/pages/cliente_detalle_screen.dart';
import 'package:registro_productos/pages/clientes_screen.dart';
import 'package:registro_productos/pages/productos_detalle_screen.dart';
import 'package:registro_productos/pages/productos_screen.dart';
import 'package:registro_productos/pages/ventas_detalle_screen.dart';
import 'package:registro_productos/pages/ventas_screen.dart';

final router = GoRouter(initialLocation: '/ventas', routes: [
  GoRoute(
    path: '/ventas',
    name: 'ventas',
    builder: (context, state) => const VentasScreen(),
  ),
  GoRoute(
    path: '/ventas/:id',
    name: 'venta',
    builder: (context, state) =>
        VentaDetalleScreen(idVenta: state.pathParameters['id']!),
  ),
  GoRoute(
    path: '/clientes',
    name: 'clientes',
    builder: (context, state) => const ClientesScreen(),
  ),
  GoRoute(
    path: '/clientes/:id',
    name: 'cliente',
    builder: (context, state) =>
        ClienteDetalleScreen(idCliente: state.pathParameters['id']!),
  ),
  GoRoute(
    path: '/productos',
    name: 'productos',
    builder: (context, state) => const ProductosScreen(),
  ),
  GoRoute(
    path: '/productos/:id',
    name: 'producto',
    builder: (context, state) =>
        ProductoDetalleScreen(idProducto: state.pathParameters['id']!),
  ),
  GoRoute(
    path: '/categorias',
    name: 'categorias',
    builder: (context, state) => const CategoriasScreen(),
  ),
]);
