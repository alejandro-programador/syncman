import 'package:flutter/material.dart';
import 'package:syncman_new/screens/system/bill_detail.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/utils/date_utils.dart';

class BillCardModel extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final String emissionDate;
  final String expirationDate;
  final String amount;
  final int pending;
  final bool? devolution;
  final Map<String, dynamic>? billSelected;

  const BillCardModel({
    required this.title,
    required this.description,
    required this.location,
    required this.emissionDate,
    required this.expirationDate,
    required this.amount,
    required this.pending,
    this.devolution = false,
    this.billSelected = const {},
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String truncatedDescription =
        description.length > 22 ? "${description.substring(0, 22)}..." : description;

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FACTURA',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Text(
                      truncatedDescription,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      location,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  color: Colors.white,
                  icon: const Icon(Icons.more_horiz, color: Colors.grey),
                  onSelected: (String value) {
                    if (value == 'show') {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => BillDetailView(billData: billSelected ?? {})),
                      // );
                      // Navigator.pushNamed(context, "/client-profile");
                    } else if (value == 'order') {
                      //  Navigator.pushNamed(context, "/client-profile");
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      if (devolution != true)
                        PopupMenuItem(
                          value: 'show',
                          child: Row(
                            children: [
                              Image.asset('assets/icons/fluent_apps-list-detail-24-regular.png',
                                  width: 20, height: 20),
                              const SizedBox(width: 8),
                              Text('Ver detalle',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppTheme.primaryColor)),
                            ],
                          ),
                        ),
                      if (devolution == true)
                        PopupMenuItem(
                          value: 'devolution',
                          child: Row(
                            children: [
                              Image.asset('assets/icons/ion_return-down-back-outline (1).png',
                                  width: 20, height: 20),
                              const SizedBox(width: 8),
                              Text('Crear devolución',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppTheme.primaryColor)),
                            ],
                          ),
                        ),
                      PopupMenuItem(
                        value: 'order',
                        child: Row(
                          children: [
                            Image.asset('assets/icons/mynaui_share.png', width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('Compartir', style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
            const Divider(color: AppTheme.greyBackground),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fecha emisión',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: AppTheme.greyColor),
                    ),
                    Text(DateUtilsHelper.formatDate(emissionDate),
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vencimiento',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.red),
                    ),
                    Text(DateUtilsHelper.formatDate(expirationDate),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                            )),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: AppTheme.greyColor),
                    ),
                    Text('USD $amount', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pendiente',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: AppTheme.greyColor),
                    ),
                    Text(pending == 0 ? '0' : '$pending',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w700, color: AppTheme.primaryColor)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
