import 'package:flutter/material.dart';

class SupervisorProfileView extends StatelessWidget {
  const SupervisorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          "Perfil",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Profile Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Picture and Edit Icon
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://picsum.photos/150',
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Name and Role
                  const Text(
                    'Zugey Gutierrez',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Supervisor',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[900],
                        ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            // Menu Items Section
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  _buildMenuItem(context, 'Vendedores', 'iconamoon_profile-light.png'),
                  _buildMenuItem(context, 'Cobros', 'solar_wallet-outline.png'),
                  _buildMenuItem(context, 'Facturas', 'solar_bill-check-linear.png'),
                  _buildMenuItem(context, 'Valija', 'solar_money-bag-outline.png'),
                  _buildMenuItem(context, 'Devoluciones', 'ion_return-down-back-outline.png'),
                  _buildMenuItem(context, 'Reporte', 'carbon_report.png'),
                  _buildMenuItem(context, 'Resumen', 'solar_document-linear.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Menu Item Builder
  Widget _buildMenuItem(BuildContext context, String title, String url) {
    return ListTile(
      leading: Image.asset('assets/icons/$url', width: 20, height: 20),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 11),
      onTap: () {
        // Add navigation or functionality
      },
    );
  }
}
