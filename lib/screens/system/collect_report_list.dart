import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

import 'package:syncman_new/widgets/notification.dart';

class CollectReport2View extends StatelessWidget {
  const CollectReport2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Reporte de cobros", style: TextStyle(fontSize: 18)),
          ],
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/icons/illustration.png',
                                      width: 24,
                                      height: 24,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'COBRO',
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: AppTheme.greyColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      '#123456',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    Text('Ferretería Los Juanes C.A.',
                                        style: Theme.of(context).textTheme.bodySmall),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: index == 2 ? Colors.red[100] : Colors.green[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    index == 2 ? 'Pendiente' : 'Finalizado',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: index == 2 ? Colors.red : Colors.green,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: AppTheme.greyBackground,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pago mixto', style: Theme.of(context).textTheme.bodySmall),
                                  Text('Divisas y trans. nacional',
                                      style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('\$1.000',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.primaryColor)),
                                ],
                              ),
                            ]),
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Detalles de transacción',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          )),
                                  const Icon(Icons.keyboard_arrow_up),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text('Fecha',
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.w400, color: AppTheme.greyColor)),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text('Referencia',
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.w400, color: AppTheme.greyColor)),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text('Observación',
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.w400, color: AppTheme.greyColor)),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text('Total',
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.w400, color: AppTheme.greyColor)),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                ]),
                                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                  Text('Octubre 28, 2024  3:40pm',
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.w400, color: AppTheme.greyColor)),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text('Pago',
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.w400, color: AppTheme.greyColor)),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text('Dejó 280',
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.w400, color: AppTheme.greyColor)),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    '\$1.000,45',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w700, color: AppTheme.primaryColor),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                ]),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blue, width: 2), // Border color & thickness
                                    borderRadius:
                                        BorderRadius.circular(8), // Optional: Round corners
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image.asset('assets/icons/gallery.png',
                                        width: 24, height: 24),
                                  )),
                            ])
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
