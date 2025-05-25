import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncman_new/providers/cart_provider.dart';
import 'package:syncman_new/routes/routes.dart';
import 'package:syncman_new/screens/system/product.dart';
import 'package:syncman_new/screens/system/collect_report.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/providers/selected_client_provider.dart';

class ClientCard2 extends StatelessWidget {
  final String title;
  final String description;
  final String subtitle;
  final String saldocxc;
  final bool isRecent;
  final String saldodeudor;
  final String saldototal;
  final String daysAgo;
  final int selectedCategory;
  final String clientId;
  final bool clientContrib;

  const ClientCard2({
    required this.title,
    required this.description,
    required this.subtitle,
    required this.saldocxc,
    required this.saldodeudor,
    required this.saldototal,
    required this.daysAgo,
    required this.isRecent,
    required this.selectedCategory,
    required this.clientId,
    required this.clientContrib,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust truncation based on screen width
    String truncatedDescription = description.length > (screenWidth > 360 ? 32 : 25)
        ? "${description.substring(0, screenWidth > 360 ? 32 : 25)}..."
        : description;

    String getClientType() {
      double saldodeudorValue = double.parse(saldodeudor.replaceAll('\$', ''));
      double saldocxcValue = double.parse(saldocxc.replaceAll('\$', ''));
      double saldototalValue = double.parse(saldototal.replaceAll('\$', ''));

      if (saldodeudorValue > 0) return 'Moroso';

      if (saldocxcValue > 0 && saldodeudorValue <= 0) return 'Al día';

      if (saldototalValue <= 0) return 'CXC';

      return '';
    }

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CLIENTE",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Flexible(
                                  child: Chip(
                                    label: Text(
                                      getClientType(),
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                            color: getClientType() != 'Moroso'
                                                ? AppTheme.greenColor
                                                : Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    backgroundColor: getClientType() != 'Moroso'
                                        ? Colors.green[50]
                                        : Colors.red[50],
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 72.0),
                          Row(
                            children: [
                              Column(
                                children: [
                                  PopupMenuButton<String>(
                                    color: Colors.white,
                                    icon: const Icon(Icons.more_horiz, color: Colors.grey),
                                    onSelected: (String value) {
                                      // Handle menu actions here
                                      if (value == 'show') {
                                        Navigator.pushNamed(context, "/client-profile");
                                      } else if (value == 'order') {
                                        //  Navigator.pushNamed(context, "/client-profile");
                                      } else if (value == 'collection') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const CollectReport(),
                                            settings: RouteSettings(
                                              arguments: {'clientId': clientId},
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: 'show',
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  'assets/icons/iconamoon_profile-light.png',
                                                  width: 20,
                                                  height: 20),
                                              const SizedBox(width: 8),
                                              Text('Ver Cliente',
                                                  style: Theme.of(context).textTheme.bodyMedium),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'order',
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences.getInstance();

                                            // Save selected client id
                                            await prefs.setString('id_cliente_pedido', clientId);

                                            // Save contrib
                                            await prefs.setBool('cliente_contrib', clientContrib);

                                            // Save user data
                                            context.read<CartProvider>().saveUserSelected({
                                              // * Test
                                              'code': title,
                                              'name': description
                                            });

                    
                                            Navigator.pushNamed(context, Routes.product);
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset('assets/icons/Vector.png',
                                                  width: 20, height: 20),
                                              const SizedBox(width: 8),
                                              Text('Crear Pedido',
                                                  style: Theme.of(context).textTheme.bodyMedium),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'collection',
                                          onTap: () async {
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            // Save client ID for collection
                                            await prefs.setString('id_cliente_cobro', clientId);
                                            
                                            // Save client data in provider
                                            context.read<SelectedClientProvider>().setSelectedClient(
                                              clientId: clientId,
                                              clientName: title,
                                              clientPhone: subtitle,
                                              clientCompany: description,
                                              clientCode: clientId,
                                            );
                                            
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const CollectReport(),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset('assets/icons/wallet.png',
                                                  width: 20, height: 20),
                                              const SizedBox(width: 8),
                                              Text('Realizar Cobro',
                                                  style: Theme.of(context).textTheme.bodyMedium),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'bills',
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  'assets/icons/solar_bill-check-linear.png',
                                                  width: 20,
                                                  height: 20),
                                              const SizedBox(width: 8),
                                              Text('Ver Facturas',
                                                  style: Theme.of(context).textTheme.bodyMedium),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'valija',
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  'assets/icons/solar_money-bag-outline.png',
                                                  width: 20,
                                                  height: 20),
                                              const SizedBox(width: 8),
                                              Text('Valija',
                                                  style: Theme.of(context).textTheme.bodyMedium),
                                            ],
                                          ),
                                        ),
                                      ];
                                    },
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Text(
                        truncatedDescription,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (selectedCategory == 3)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("SaldoCXC",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
                      Text(
                        saldocxc,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                if (selectedCategory == 3) const SizedBox(width: 20),
                if (selectedCategory != 3)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Saldo Deudor",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
                      Text(
                        saldodeudor,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Saldo Total",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
                    Text(
                      saldototal,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const SizedBox(width: 20),
                // const SizedBox(width: 60),
                Column(children: [
                  Text(
                    daysAgo,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w500),
                  ),
                ])
              ],
            ),
          ],
        ),
      ),
    );
  }
}
