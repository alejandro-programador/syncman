import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/providers/client_provider.dart';
import 'package:syncman_new/routes/routes.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/menu.dart';

class ClientProfileView extends StatefulWidget {
  final String clientDNI;
  const ClientProfileView({super.key, required this.clientDNI});

  @override
  State<ClientProfileView> createState() => _ClientProfileViewState();
}

class _ClientProfileViewState extends State<ClientProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientsProvider>().fetchClientData(widget.clientDNI);
    });
  }

  @override
  Widget build(BuildContext context) {
    final clientsProvider = context.watch<ClientsProvider>();

    String getClientType() {
      if (clientsProvider.clientProfile['saldo_deudor'] > 0) return 'Moroso';

      if (clientsProvider.clientProfile['saldoCXC'] > 0 &&
          clientsProvider.clientProfile['saldo_deudor'] <= 0) return 'Al día';

      if (clientsProvider.clientProfile['saldo_deudor_total'] <= 0) {
        return 'CXC';
      }

      return '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Detalle de cliente",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
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
      body: clientsProvider.isLoading
          ? const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Client Card
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/client-detail");
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Profile image
                                  const Column(
                                    children: [
                                      SizedBox(
                                        width: 68,
                                        height: 67,
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              'https://via.placeholder.com/150'), // Replace with actual image
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "CLIENTE",
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              color: AppTheme.greyColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              clientsProvider.clientProfile['codigo'] ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Chip(
                                              label: Text(
                                                getClientType(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                      color: getClientType() != 'Moroso'
                                                          ? AppTheme.greenColor
                                                          : Colors.red,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                              backgroundColor: getClientType() != 'Moroso'
                                                  ? Colors.green[50]
                                                  : Colors.red[50],
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(color: Colors.transparent),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          softWrap: true,
                                          clientsProvider.clientProfile['telefonos'] ?? '',
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              color: AppTheme.greyColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Column(
                                    children: [
                                      Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 10),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  // Address Section
                                  Text(
                                    "DIRECCIÓN",
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      softWrap: true,
                                      clientsProvider.clientProfile['direccion'] ?? '',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Financial Details
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFinancialDetail(context, "SALDO DEUDOR",
                                "\$${clientsProvider.clientProfile['saldo_deudor']}",
                                isBigTitle: true),
                            const Divider(
                              height: 16,
                              color: AppTheme.greyBackground,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _buildFinancialDetail(context, "SALDO TOTAL",
                                    "\$${clientsProvider.clientProfile['saldo_deudor_total']}"),
                                const SizedBox(width: 24.0),
                                _buildFinancialDetail(
                                  context,
                                  "SALDO CXC",
                                  "\$${clientsProvider.clientProfile['saldoCXC']}",
                                  // isHighlighted: true,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFinancialDetail(context, "TOTAL VENTAS (MES)",
                                "\$${clientsProvider.clientProfile['totalMes']}",
                                isBigTitle: true),
                            const Divider(
                              height: 16,
                              color: AppTheme.greyBackground,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _buildFinancialDetail(
                                  context,
                                  "ESTA SEMANA",
                                  "\$${clientsProvider.clientProfile['totalsemana']}",
                                ),
                                const SizedBox(width: 24.0),
                                _buildFinancialDetail(
                                  context,
                                  "HOY",
                                  "\$${clientsProvider.clientProfile['totalDia']}",
                                  isHighlighted: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Sales Section

                    const SizedBox(height: 20),

                    // Pending Orders
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Image.asset('assets/icons/timer.png', width: 24, height: 24),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("PEDIDOS PENDIENTES",
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
                              Text("\$${clientsProvider.clientProfile['totalPendientes']}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(width: 60),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios, size: 16),
                                onPressed: () {}, // Acción al presionar la flecha
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Action Buttons
                    Text(
                      "ACCIONES",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: [
                        _buildActionButton(context, Icons.edit, "Pedidos", "Icon.png"),
                        _buildActionButton(context, Icons.people, "Clientes", "Icon (1).png"),
                        _buildActionButton(context, Icons.attach_money, "Cobros", "Icon (2).png"),
                        _buildActionButton(context, Icons.receipt, "Facturas", "Icon (3).png"),
                        _buildActionButton(context, Icons.map, "Ver mapa", "Icon (4).png"),
                        _buildActionButton(
                            context, Icons.call, "Llamar", "ic_baseline-assignment-return.png"),
                        _buildActionButton(context, Icons.dashboard, "Resumen", "Icon (5).png"),
                        _buildActionButton(context, Icons.bar_chart, "Reporte", "Icon (6).png"),
                        _buildActionButton(context, Icons.wallet, "Valija", "Icon (7).png"),
                        _buildActionButton(
                          context,
                          Icons.replay,
                          "Devolución",
                          "Icon (8).png",
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.refund);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildFinancialDetail(BuildContext context, String label, String value,
      {bool isHighlighted = false, bool isBigTitle = false}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: isBigTitle ? 24.0 : 16.0,
          fontWeight: isBigTitle ? FontWeight.w700 : FontWeight.w600,
          color: isHighlighted ? Colors.red : Colors.black,
        ),
      ),
    ]);
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String title, String asset,
      {VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed, // Ejecuta la función si está definida
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/$asset',
            width: 32,
            height: 32,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
