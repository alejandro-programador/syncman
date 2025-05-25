import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class PaymentCard extends StatelessWidget {
  final String title;
  final String description;
  final String amount;
  final String articles;
  final bool isRecent;
  final String daysAgo;
  final Icon? customIcon;
  final String clientName;
  final Map<String, dynamic> client;

  const PaymentCard({
    required this.title,
    required this.description,
    required this.amount,
    required this.articles,
    required this.isRecent,
    required this.daysAgo,
    this.customIcon,
    required this.clientName,
    required this.client,
    super.key,
  });

  // Future<String> fetchUserType() async {
  //   if (client['saldoCXC'] > 0 && client['saldo_deudor'] <= 0) return 'CXC';
  //   if (client['saldo_deudor'] > 0) return 'Moroso';
  //   if (client['saldo_deudor_total'] <= 0) return 'Al día';

  //   return '';
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.greyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    // Text(
                    //   clientName,
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .bodyMedium
                    //       ?.copyWith(fontWeight: FontWeight.w500),
                    // ),
                    // Text(
                    //   clientName,
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .bodySmall
                    //       ?.copyWith(color: AppTheme.greyColor),
                    // ),
                  ],
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Chip(
                      label: Text(
                        client['userType'] ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: client['userType'] == 'Moroso'
                                    ? Colors.red
                                    : Colors.green,
                                fontWeight: FontWeight.w500),
                      ),
                      backgroundColor: client['userType'] == 'Moroso'
                          ? Colors.red[50]
                          : Colors.green[50],
                      side: BorderSide.none,
                    ),
                  ],
                ),
                Column(
                  children: [
                    PopupMenuButton<String>(
                      color: Colors.white,
                      icon: customIcon ??
                          const Icon(Icons.more_vert, color: Colors.grey),
                      onSelected: (String value) {
                        // Handle menu actions here
                        if (value == 'show') {
                          Navigator.pushNamed(context, "/client-profile");
                        } else if (value == 'order') {
                          //  Navigator.pushNamed(context, "/client-profile");
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'order',
                            child: Row(
                              children: [
                                Image.asset('assets/icons/Vector.png',
                                    width: 20, height: 20),
                                const SizedBox(width: 8),
                                Text('Crear Pedido',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'collection',
                            child: Row(
                              children: [
                                Image.asset('assets/icons/wallet.png',
                                    width: 20, height: 20),
                                const SizedBox(width: 8),
                                Text('Realizar Cobro',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TOTAL PEDIDO",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.greyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      amount,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "ARTÍCULOS",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.greyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      articles,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8.0,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      daysAgo,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.greyColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
