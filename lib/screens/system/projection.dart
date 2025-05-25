import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/notification.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/providers/dashboard_provider.dart';
import 'package:intl/intl.dart';

class ProjectionView extends StatelessWidget {
  const ProjectionView({super.key});

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
            const Text("Proyección", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Consumer<DashboardProvider>(
              builder: (context, provider, child) {
                final lastUpdate = provider.dashboard.updatedAt;
                final formattedDate = lastUpdate != null
                    ? DateFormat('HH:mm a').format(lastUpdate)
                    : '--:-- --';
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/refresh.png', width: 12, height: 14),
                    const SizedBox(width: 4),
                    Text("Hoy $formattedDate",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontFamily: 'Mulish')),
                  ],
                );
              },
            )
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
                MaterialPageRoute(
                    builder: (context) => const NotificationsView()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset('assets/icons/notification.png',
                  width: 28, height: 28),
            ),
          )
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Consumer<DashboardProvider>(
        builder: (context, provider, child) {
          final dashboard = provider.dashboard;
          
          // Calculate progress values
          final ventasProgress = dashboard.proyeccionTotalVendido != null && 
              dashboard.proyeccionTotalVendidoAcum != null && 
              dashboard.proyeccionTotalVendidoAcum! > 0
              ? dashboard.proyeccionTotalVendido! / dashboard.proyeccionTotalVendidoAcum!
              : 0.0;

          final clientesProgress = dashboard.proyeccionCantidadClientes != null && 
              dashboard.proyeccionCantidadClientesAcum != null && 
              dashboard.proyeccionCantidadClientesAcum! > 0
              ? dashboard.proyeccionCantidadClientes! / dashboard.proyeccionCantidadClientesAcum!
              : 0.0;

          final articulosProgress = dashboard.proyeccionCantidadProductos != null && 
              dashboard.proyeccionCantidadProductosAcum != null && 
              dashboard.proyeccionCantidadProductosAcum! > 0
              ? dashboard.proyeccionCantidadProductos! / dashboard.proyeccionCantidadProductosAcum!
              : 0.0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: _buildCircularProgressIndicator(
                      context,
                      totalVentas: dashboard.proyeccionTotalVendido ?? 0,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildStatCard(
                  context,
                  title: "VENTAS",
                  value: "\$${NumberFormat('#,##0.00').format(dashboard.proyeccionTotalVendido ?? 0)}",
                  progress: ventasProgress,
                  meta: "\$${NumberFormat('#,##0.00').format(dashboard.proyeccionTotalVendidoAcum ?? 0)}",
                  missing: "\$${NumberFormat('#,##0.00').format((dashboard.proyeccionTotalVendidoAcum ?? 0) - (dashboard.proyeccionTotalVendido ?? 0))}",
                  progressColor: Colors.blue,
                ),
                const SizedBox(height: 16),
                _buildStatCard(
                  context,
                  title: "CLIENTES",
                  value: "${dashboard.proyeccionCantidadClientes ?? 0}",
                  progress: clientesProgress,
                  meta: "${dashboard.proyeccionCantidadClientesAcum ?? 0}",
                  missing: "${(dashboard.proyeccionCantidadClientesAcum ?? 0) - (dashboard.proyeccionCantidadClientes ?? 0)}",
                  progressColor: Colors.red,
                  value2: '${dashboard.clientesConPedidosHoy ?? 0}',
                  value3: '${dashboard.clientesSinPedidosHoy ?? 0}',
                ),
                const SizedBox(height: 16),
                _buildStatCard(
                  context,
                  title: "ARTÍCULOS",
                  value: "${dashboard.proyeccionCantidadProductos ?? 0}",
                  progress: articulosProgress,
                  meta: "${dashboard.proyeccionCantidadProductosAcum ?? 0}",
                  missing: "${(dashboard.proyeccionCantidadProductosAcum ?? 0) - (dashboard.proyeccionCantidadProductos ?? 0)}",
                  progressColor: Colors.blue,
                ),
                const SizedBox(height: 16),
                _buildStatCard(
                  context,
                  title: "CXC DESPACHO",
                  value: "\$${NumberFormat('#,##0.00').format(dashboard.montoAdeudado ?? 0)}",
                  progress: 0.8,
                  meta: "\$${NumberFormat('#,##0.00').format((dashboard.montoAdeudado ?? 0) * 1.25)}",
                  missing: "\$${NumberFormat('#,##0.00').format((dashboard.montoAdeudado ?? 0) * 0.25)}",
                  progressColor: Colors.blue,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircularProgressIndicator(BuildContext context, {required double totalVentas}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const SizedBox(
              width: 205,
              height: 204,
              child: CircularProgressIndicator(
                value: 0.7,
                strokeWidth: 20,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: AppTheme.greyBackground,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "TOTAL VENTAS",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppTheme.greyColor),
                ),
                Text(
                  "\$${NumberFormat('#,##0.00').format(totalVentas)}",
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChip(context, "S"),
            const SizedBox(width: 8),
            _buildChip(context, "M", isActive: true),
            const SizedBox(width: 8),
            _buildChip(context, "A"),
          ],
        ),
      ],
    );
  }

  Widget _buildChip(BuildContext context, String label,
      {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.greyBackground : Colors.white,
        borderRadius: BorderRadius.circular(5),
        // border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context,
      {required String title,
      required String value,
      required double progress,
      required String meta,
      required String missing,
      required Color progressColor,
      String? value2,
      String? value3}) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600, color: AppTheme.greyColor)),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8), // Add border radius here
                    child: LinearProgressIndicator(
                      value: progress,
                      color: progressColor,
                      backgroundColor: Colors.grey.shade300,
                      minHeight:
                          8.0, // Keep the height consistent with the theme
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(fontSize: 16, color: progressColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(children: [
                  Image.asset('assets/icons/goal.png', width: 22, height: 22),
                ]),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("META",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.greyColor)),
                    Text(
                      meta,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(width: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("MONTO FALTANTE",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.greyColor)),
                    Text(
                      missing,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            if (value2 != null && value3 != null) const SizedBox(height: 16),
            if (value2 != null && value3 != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 38.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("COMPRADO",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.greyColor)),
                      Text(
                        value2,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("NO HAN COMPRADO",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.greyColor)),
                      Text(
                        value3,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
