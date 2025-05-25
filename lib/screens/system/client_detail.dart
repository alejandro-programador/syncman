import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/extensions/theme_extension.dart';
import 'package:syncman_new/providers/client_provider.dart';
import 'package:syncman_new/widgets/menu.dart';

class ClientDetailView extends StatelessWidget {
  const ClientDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final clientsProvider = context.watch<ClientsProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuView()),
            );
          },
        ),
        title: Text(
          "Detalle de cliente",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            ClientDetailCard(
                title: 'EMPRESA',
                description: clientsProvider.clientProfile['descripcion'] ?? 'Sin descripción'),
            ClientDetailCard(
                title: 'RIF', description: clientsProvider.clientProfile['rif'] ?? 'Sin RIF'),
            ClientDetailCard(
                title: 'TELÉFONO',
                description: clientsProvider.clientProfile['telefonos'] ?? 'Sin teléfono'),
            ClientDetailCard(
                title: 'CORREO',
                description: clientsProvider.clientProfile['email'] ?? 'Sin correo'),
            ClientDetailCard(
                title: 'DIRECCIÓN',
                description: clientsProvider.clientProfile['direccion'] ?? 'Sin dirección'),
          ],
        ),
      ),
    );
  }
}

class ClientDetailCard extends StatelessWidget {
  final String title;
  final String description;

  const ClientDetailCard({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Flexible Text Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.textTheme.labelSmall
                            ?.copyWith(color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
