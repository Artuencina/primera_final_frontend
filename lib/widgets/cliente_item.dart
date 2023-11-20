import 'package:flutter/material.dart';
import 'package:registro_productos/models/cliente.dart';

class ClienteItem extends StatelessWidget {
  const ClienteItem({
    super.key,
    required this.icon,
    required this.color,
    required this.cliente,
    required this.deleteCliente,
    required this.updateCliente,
  });

  final IconData icon;
  final Color color;
  final Cliente cliente;
  final Function(Cliente) deleteCliente;
  final Function(Cliente) updateCliente;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        deleteCliente(cliente);
      },
      key: ValueKey(cliente.id),
      child: Card(
        color: color,
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              //Propiedades de la persona
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cliente.nombre} ${cliente.apellido}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${cliente.email}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.credit_card,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${cliente.ruc}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              //Botones para editar y eliminar
              const Spacer(),
              IconButton(
                onPressed: () {
                  updateCliente(cliente);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  deleteCliente(cliente);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}