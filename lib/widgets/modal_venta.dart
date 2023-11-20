//Pantalla para agregar venta
//Donde muestra un formulario para agregar una venta
//Que tiene un numero de venta con formato 0010010000001
//Un campo para seleccionar el cliente
//Un campo para fecha
//Un campo para agregar productos y sus cantidades
//Un texto al final que muestra el total de la venta
//Y un boton para guardar la venta en el appbar

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:registro_productos/models/cliente.dart';
import 'package:registro_productos/models/venta.dart';
import 'package:registro_productos/provider/clientes_provider.dart';
import 'package:registro_productos/provider/ventas_provider.dart';
import 'package:registro_productos/widgets/search_producto.dart';

class ModalVenta extends ConsumerStatefulWidget {
  const ModalVenta({super.key});

  @override
  ConsumerState<ModalVenta> createState() => _ModalVentaState();
}

class _ModalVentaState extends ConsumerState<ModalVenta> {
  final formkey = GlobalKey<FormState>();

  String numeroFactura = ''; //Se genera automaticamente
  Cliente? cliente;
  double total = 0;
  DateTime fecha = DateTime.now();
  List<VentaDetalle> ventaDetalle = [];

  //Controllers
  final fechaController = TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  );

  @override
  Widget build(BuildContext context) {
    //Obtener nuevo numero de factura
    numeroFactura = ref.read(ventasProvider.notifier).nuevaFactura;

    final clientes = ref.watch(clientesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Venta'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (formkey.currentState!.validate()) {
                //Guardar la venta
                final venta = Venta(
                  numeroFactura: numeroFactura,
                  cliente: cliente!,
                  fecha: fecha,
                  ventaDetalle: ventaDetalle,
                  total: total,
                );
                Navigator.of(context).pop(venta);
              }
            },
          )
        ],
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            //Fecha con datepicker
            TextFormField(
              controller: fechaController,
              decoration: const InputDecoration(
                labelText: 'Fecha',
                icon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ingrese la fecha';
                }
                return null;
              },
              //Si cambia la fecha manualmente
              //vamos a guardar el valor en la variable fecha
              onChanged: (value) {
                setState(() {
                  fecha = DateFormat('dd/MM/yyyy').parse(value);
                });
              },
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: fecha,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2025),
                );
                if (date != null) {
                  setState(() {
                    fecha = date;
                    fechaController.text =
                        DateFormat('dd/MM/yyyy').format(fecha);
                  });
                }
              },
            ),
            //Numero de factura
            TextFormField(
              initialValue: numeroFactura,
              decoration: const InputDecoration(
                labelText: 'Numero de Factura',
                icon: Icon(Icons.receipt_long),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ingrese el numero de factura';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  numeroFactura = value;
                });
              },
            ),
            //Cliente
            DropdownButtonFormField<Cliente>(
              value: cliente,
              decoration: const InputDecoration(
                labelText: 'Cliente',
                icon: Icon(Icons.person),
              ),
              items: clientes
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text('${e.nombre} ${e.apellido}'),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  cliente = value!;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Seleccione un cliente';
                }
                return null;
              },
            ),
            //Total
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total'),
                  Text(
                    //Formatear para moneda
                    NumberFormat.simpleCurrency(name: 'PYG').format(total),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            //Productos
            //Container que avisa que no hay productos y se extiende a todo el ancho
            //y lo que pueda ocupar de alto
            const Divider(),
            Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Agregar producto
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_bag),
                        const SizedBox(width: 10),
                        const Text('Productos', style: TextStyle(fontSize: 20)),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () async {
                            //Mostrar modal de busqueda
                            //Y agregar el producto a la lista
                            //Si fue seleccionado

                            final producto = await showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => const SearchProducto(),
                            );

                            if (producto != null) {
                              setState(() {
                                ventaDetalle.add(
                                  VentaDetalle(
                                    producto: producto,
                                    cantidad: 1,
                                  ),
                                );
                                total += producto.precio;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    //Divisor

                    //Lista de productos
                    ventaDetalle.isEmpty
                        ? const Center(
                            child: Text('No hay productos agregados'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: ventaDetalle.length,
                            itemBuilder: (context, index) {
                              final detalle = ventaDetalle[index];

                              return Dismissible(
                                key: ValueKey(detalle.producto.id),
                                background: Container(
                                  color: Colors.red,
                                  child: const Icon(Icons.delete),
                                ),
                                onDismissed: (direction) {
                                  setState(() {
                                    ventaDetalle.removeAt(index);
                                  });
                                },
                                child: ListTile(
                                  title: Text(detalle.producto.nombreProducto),
                                  subtitle: Text(
                                    NumberFormat.simpleCurrency(name: 'PYG')
                                        .format(detalle.producto.precio),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          setState(() {
                                            detalle.cantidad--;
                                            total -= detalle.producto.precio;
                                          });
                                        },
                                      ),
                                      Text(detalle.cantidad.toString()),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            detalle.cantidad++;
                                            total += detalle.producto.precio;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
