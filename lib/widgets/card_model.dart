import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class CardModel extends StatelessWidget {
  final String title;
  final String description;
  final String subtitle;
  final String amount;
  final String articles;
  final bool isRecent;
  final String daysAgo;
  final String miniTitle;
  final bool? isDetail;
  final bool? isOrderReport;

  const CardModel({
    required this.title,
    required this.description,
    required this.subtitle,
    required this.amount,
    required this.articles,
    required this.isRecent,
    required this.daysAgo,
    required this.miniTitle,
    this.isDetail,
    this.isOrderReport,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                      miniTitle,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.greyColor,
                          fontWeight: FontWeight.w600),
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
                      description,
                      style: (isOrderReport != null)
                          ? Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500)
                          : Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.greyColor,
                              fontWeight: FontWeight.w600),
                    ),
                    Text(
                      subtitle,
                      style: (isOrderReport != null)
                          ? Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppTheme.greyColor)
                          : Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppTheme.greyColor,
                              fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  color: Colors.white,
                  icon: const Icon(Icons.more_horiz, color: Colors.grey),
                  onSelected: (String value) {
                    if (value == 'show') {
                      Navigator.pushNamed(context, "/client-profile");
                    } else if (value == 'order') {
                      //  Navigator.pushNamed(context, "/client-profile");
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      if (isDetail == null)
                        PopupMenuItem(
                          value: 'show',
                          child: Row(
                            children: [
                              Image.asset(
                                  'assets/icons/fluent_apps-list-detail-24-regular.png',
                                  width: 20,
                                  height: 20),
                              const SizedBox(width: 8),
                              Text('Ver detalle',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppTheme.primaryColor)),
                            ],
                          ),
                        ),
                      if (isDetail != null)
                        PopupMenuItem(
                          value: 'devolution',
                          child: Row(
                            children: [
                              Image.asset(
                                  'assets/icons/ion_return-down-back-outline (1).png',
                                  width: 20,
                                  height: 20),
                              const SizedBox(width: 8),
                              Text('Crear devolución',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppTheme.primaryColor)),
                            ],
                          ),
                        ),
                      if (isOrderReport == null)
                        PopupMenuItem(
                          value: 'order',
                          child: Row(
                            children: [
                              Image.asset('assets/icons/mynaui_share.png',
                                  width: 20, height: 20),
                              const SizedBox(width: 8),
                              Text('Compartir',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                    ];
                  },
                ),
              ],
            ),
            const Divider(color: AppTheme.greyBackground),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL PEDIDO',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.greyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Text('\$1.956,00',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ARTÍCULOS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.greyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Text('70',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FECHA',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.greyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Text('05/02/2025',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
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
