import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pedidos Section
            const Text(
              'PEDIDOS',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildStatCard(
              icon: Icons.file_copy,
              label: 'PEDIDOS CREADOS',
              value: '3.597',
            ),
            const SizedBox(height: 10),
            _buildStatCard(
              icon: Icons.hourglass_bottom,
              label: 'PARCIALMENTE CREADOS',
              value: '345',
            ),
            const SizedBox(height: 10),
            _buildStatCard(
              icon: Icons.check_box,
              label: 'COMPLETADOS',
              value: '5.689',
            ),
            const SizedBox(height: 20),

            // Clientes Section
            const Text(
              'CLIENTES',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.group,
                    label: 'PROYECCIÓN DE CLIENTES',
                    value: '10',
                    isCircularProgress: true,
                    progressValue: 0.08,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.warning,
                    label: 'MOROSOS',
                    value: '5.689',
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.check_circle,
                    label: 'AL DÍA',
                    value: '5.689',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.shopping_cart_outlined,
                    label: 'NO HAN COMPRADO',
                    value: '5.689',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.shopping_cart,
                    label: 'HAN COMPRADO',
                    value: '5.689',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    Color? color,
    bool isCircularProgress = false,
    double progressValue = 0.0,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 36, color: color ?? Colors.blue),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            isCircularProgress
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          value: progressValue,
                          color: Colors.red,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                      Text('${(progressValue * 100).toInt()}%'),
                    ],
                  )
                : Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color ?? Colors.black,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
