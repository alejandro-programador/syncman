import 'package:flutter/material.dart';
import 'package:syncman_new/screens/info/help_center.dart';
import 'package:syncman_new/screens/system/bill.dart';
import 'package:syncman_new/screens/system/client.dart';
import 'package:syncman_new/screens/system/collect.dart';
import 'package:syncman_new/screens/system/home.dart';
import 'package:syncman_new/screens/system/order.dart';
import 'package:syncman_new/screens/system/product.dart';
import 'package:syncman_new/screens/system/product_catalog.dart';
import 'package:syncman_new/screens/system/refund.dart';
import 'package:syncman_new/screens/system/report.dart';
import 'package:syncman_new/screens/system/seller.dart';
import 'package:syncman_new/screens/system/summary.dart';
import 'package:syncman_new/screens/system/valija.dart';
import 'package:syncman_new/test_articles.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/utils/shared_prefs_helper.dart';
import 'package:syncman_new/widgets/notification.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          width: 125,
          height: 22,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black, size: 25),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Acciones',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 10),
              _buildMenuItem(
                context,
                Icons.dashboard,
                'assets/icons/Icon (6).png',
                'Dashboard',
                redirectTo: const SyncManDashboard(),
              ),
              _buildMenuItem(
                context,
                Icons.notifications,
                'assets/icons/notifications.png',
                'Notificaciones',
                redirectTo: const NotificationsView(),
              ),
              _buildMenuItem(context, Icons.receipt_long, 'assets/icons/Vector.png', 'Pedidos',
                  redirectTo: const OrderView()),
              _buildMenuItem(
                  context, Icons.people, 'assets/icons/iconamoon_profile-light.png', 'Clientes', // * Sincronizado
                  redirectTo: const ClientsView()),
              _buildMenuItem(
                  context, Icons.account_balance_wallet, 'assets/icons/wallet.png', 'Cobros',
                  redirectTo: const CollectView()),
              _buildMenuItem(
                  context, Icons.article, 'assets/icons/solar_bill-check-linear.png', 'Facturas',
                  redirectTo: const BillsView()), // undefined view
              _buildMenuItem(
                  context, Icons.work, 'assets/icons/solar_money-bag-outline.png', 'Valija',
                  redirectTo: const ValijaView()),
              _buildMenuItem(context, Icons.undo, 'assets/icons/ion_return-down-back-outline.png',
                  'Devoluciones',
                  redirectTo: const RefundView()), // undefined view
              _buildMenuItem(context, Icons.bar_chart, 'assets/icons/carbon_report.png', 'Reporte',
                  redirectTo: const ReportView()),
              _buildMenuItem(context, Icons.dashboard, 'assets/icons/Vector.png', 'Resumen',
                  redirectTo: const SummaryView()),
              _buildMenuItem(context, Icons.dashboard, 'assets/icons/Vector.png', 'Vendedores',
                  redirectTo: const SellerView()),
              const SizedBox(height: 20),
              _buildMenuItem(context, Icons.dashboard, 'assets/icons/Vector.png', 'Artículos',
                  redirectTo: const ProductCatalogView()),
              const SizedBox(height: 20),
              Text(
                'General',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 10),
              _buildMenuItem(context, Icons.info, 'assets/icons/gg_info.png', 'Versión',
                  trailing: 'V.2.3.0'),
              _buildMenuItem(
                  context, Icons.help_outline, 'assets/icons/bx_support.png', 'Información',
                  redirectTo: const HelpCenterView()),
              _buildMenuItem(
                  context, Icons.logout, 'assets/icons/pepicons-pop_leave.png', 'Cerrar sesión',
                  signOut: true),
              _buildMenuItem(
                context,
                Icons.science,
                'assets/icons/solar_bill-check-linear.png',
                'Test Artículos',
                redirectTo: const TestArticlesScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String imageIcon,
    String title, {
    String? trailing,
    Widget? redirectTo,
    bool? signOut,
  }) {
    return ListTile(
      leading: Image.asset(imageIcon, width: 20, height: 20),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: trailing != null
          ? Text(
              trailing,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.greySecondary,
                    fontWeight: FontWeight.w500,
                  ),
            )
          : const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {
        if (signOut != null && signOut) {
          // remove data shred_preferences
          removeItem('authToken');
          removeItem('name');
          removeItem('reopened');

          // redirect to login
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          return;
        }

        if (redirectTo != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => redirectTo),
          );
        }
      },
    );
  }
}
