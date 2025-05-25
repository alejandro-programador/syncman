import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/extensions/theme_extension.dart';
import 'package:syncman_new/providers/dashboard_provider.dart';
import 'package:syncman_new/routes/routes.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/bottom_custom_card.dart';
import 'package:syncman_new/widgets/custom_card.dart';
import 'package:syncman_new/widgets/menu.dart';
import 'package:syncman_new/widgets/notification.dart';

class SyncManDashboard extends StatefulWidget {
  const SyncManDashboard({super.key});

  @override
  State<SyncManDashboard> createState() => _SyncManDashboardState();
}

class _SyncManDashboardState extends State<SyncManDashboard> {
  @override
  void initState() {
    super.initState();
    // Cargar los datos del dashboard cuando se inicia la pantalla
    Future.microtask(() => context.read<DashboardProvider>().loadDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 125,
                  height: 22,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/refresh.png', width: 12, height: 14),
                const SizedBox(width: 4),
                Text("Hoy 09:25 AM",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontFamily: 'Mulish')),
              ],
            )
          ],
        ),
        centerTitle: true,
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
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuView()),
            );
          },
        ),
      ),
      body: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          if (dashboardProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final dashboard = dashboardProvider.dashboard;
          
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // Facturación
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'FACTURACIÓN',
                          style: context.textTheme.labelMedium
                              ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomCard(
                    title: 'MONTO ADEUDADO',
                    amount: dashboard.montoAdeudado?.toStringAsFixed(2) ?? '0.00',
                    percent: 0.5,
                    percentText: '50%',
                    bottomCard: Row(
                      children: [
                        BottomCustomCard(
                          title: 'NO VENCIDO',
                          amount: dashboard.montoNoVencido?.toStringAsFixed(2) ?? '0.00',
                        ),
                        const SizedBox(width: 24),
                        BottomCustomCard(
                          title: 'VENCIDO',
                          amount: dashboard.montoVencido?.toStringAsFixed(2) ?? '0.00',
                          color: Colors.red,
                          arrowNext: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Proyección de Ventas
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'PROYECCIÓN DE VENTAS',
                          style: context.textTheme.labelMedium
                              ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomCard(
                    title: 'TOTAL VENTAS (MES)',
                    amount: dashboard.proyeccionTotalVendido?.toStringAsFixed(2) ?? '0.00',
                    percent: 0.5,
                    percentText: '50%',
                    bottomCard: Row(
                      children: [
                        BottomCustomCard(
                          title: 'ESTA SEMANA',
                          amount: dashboard.proyeccionTotalVendidoAcum?.toStringAsFixed(2) ?? '0.00',
                        ),
                        const SizedBox(width: 24),
                        BottomCustomCard(
                          title: 'HOY',
                          amount: '0',
                          color: Colors.red,
                        ),
                        const SizedBox(width: 24),
                        BottomCustomCard(
                          title: 'META',
                          amount: '300,000',
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.projection);
                    },
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),

                  // Pedidos Section
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'PEDIDOS',
                          style: context.textTheme.labelMedium
                              ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildStatCard(
                    context: context,
                    icon: Icons.file_copy,
                    iconImage: 'assets/icons/file.png',
                    label: 'PEDIDOS CREADOS',
                    value: dashboard.pedidosCreados?.toString() ?? '0',
                  ),
                  _buildStatCard(
                    context: context,
                    icon: Icons.hourglass_bottom,
                    iconImage: 'assets/icons/timer.png',
                    label: 'PARCIALMENTE CREADOS',
                    value: dashboard.pedidosParcialmente?.toString() ?? '0',
                  ),
                  _buildStatCard(
                    context: context,
                    icon: Icons.check_box,
                    iconImage: 'assets/icons/complete.png',
                    label: 'COMPLETADOS',
                    value: dashboard.pedidosProcesados?.toString() ?? '0',
                  ),
                  const SizedBox(height: 16),

                  // Clientes Section
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'CLIENTES',
                          style: context.textTheme.labelMedium
                              ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context: context,
                          icon: Icons.group,
                          label: 'PROYECCIÓN DE CLIENTES',
                          value: dashboard.proyeccionCantidadClientes?.toString() ?? '0',
                          isCircularProgress: true,
                          progressValue: 0.8,
                          largeValueSize: true,
                          nextButton: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context: context,
                          icon: Icons.warning,
                          label: 'MOROSOS',
                          value: dashboard.clientesDeudores?.toString() ?? '0',
                          color: Colors.red,
                          customPadding: 2.0,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildStatCard(
                          context: context,
                          icon: Icons.check_circle,
                          label: 'AL DÍA',
                          value: dashboard.clientesSolventes?.toString() ?? '0',
                          customPadding: 2.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context: context,
                          icon: Icons.shopping_cart_outlined,
                          label: 'NO COMPRAN',
                          value: dashboard.clientesSinPedidosHoy?.toString() ?? '0',
                          customPadding: 2.0,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildStatCard(
                          context: context,
                          icon: Icons.shopping_cart,
                          label: 'SI COMPRAN',
                          value: dashboard.clientesConPedidosHoy?.toString() ?? '0',
                          customPadding: 2.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    double? customPadding,
    bool largeValueSize = false,
    bool nextButton = true,
    String? iconImage,
    Color? color,
    bool isCircularProgress = false,
    double progressValue = 0.0,
    VoidCallback? onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all((customPadding != null) ? customPadding : 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (iconImage != null) Image.asset(iconImage, width: 24, height: 24),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: context.textTheme.labelSmall
                              ?.copyWith(fontWeight: FontWeight.w600, color: AppTheme.greyColor)),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: (largeValueSize == true)
                            ? const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              )
                            : context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
              isCircularProgress
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          child: CircularPercentIndicator(
                            radius: 40.0,
                            lineWidth: 12,
                            percent: progressValue,
                            center: Text(
                              '${progressValue.toStringAsFixed(1)}%',
                              style: context.textTheme.bodyMedium,
                            ),
                            progressColor: Colors.red,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              if (nextButton == true)
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: onTap,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
