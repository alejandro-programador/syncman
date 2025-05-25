import 'package:flutter/material.dart';
import 'package:syncman_new/routes/routes.dart';
import 'package:syncman_new/widgets/notification.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Reportes",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsView()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset('assets/icons/notification.png', width: 28, height: 28),
            ),
          )
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildReportItem(context,
                    icon: Icons.receipt_long_outlined,
                    label: 'Reporte de pedidos',
                    iconImage: 'Vector.png', onTap: () {
                  Navigator.pushNamed(context, Routes.orderReport);
                }),
                _buildReportItem(context,
                    icon: Icons.person_outline,
                    label: 'Reporte de clientes inactivos',
                    labelColor: Colors.blue,
                    iconImage: 'iconamoon_profile-light.png', onTap: () {
                  Navigator.pushNamed(context, Routes.inactiveClient);
                }),
                _buildReportItem(context,
                    icon: Icons.reply_outlined,
                    label: 'Reporte de devolución',
                    iconImage: 'ion_return-down-back-outline.png', onTap: () {
                  Navigator.pushNamed(context, Routes.refundReport);
                }),
                _buildReportItem(context,
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Reporte de cobros',
                    iconImage: 'solar_wallet-outline.png', onTap: () {
                  Navigator.pushNamed(context, Routes.collectReport2);
                }),
                _buildReportItem(context,
                    icon: Icons.work_outline,
                    label: 'Reporte de valijas',
                    iconImage: 'solar_money-bag-outline.png', onTap: () {
                  Navigator.pushNamed(context, Routes.valijaReport);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReportItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String iconImage,
    Color labelColor = Colors.black,
    VoidCallback? onTap, // Optional callback for redirection
  }) {
    return ListTile(
      leading: Image.asset('assets/icons/$iconImage', width: 24, height: 24),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
      onTap: onTap, // Call the provided function if not null
    );
  }
}
