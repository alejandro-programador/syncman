import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class ClientCard extends StatelessWidget {
  final String title;
  final String description;
  final String subtitle;
  final String amount;
  final String articles;
  final bool isRecent;
  final String daysAgo;
  final bool? isInactive;

  const ClientCard({
    required this.title,
    required this.description,
    required this.subtitle,
    required this.amount,
    required this.articles,
    required this.isRecent,
    required this.daysAgo,
    this.isInactive,
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
                      "CLIENTE",
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
                        const SizedBox(width: 16.0),
                        if (isInactive == true)
                          Chip(
                            label: Text(
                              "Inactivo",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            backgroundColor: AppTheme.greyBackground,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        if (isInactive != true)
                          Chip(
                            label: Text(
                              isRecent ? "Al día" : "Moro",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: isRecent
                                        ? AppTheme.greenColor
                                        : Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            backgroundColor:
                                isRecent ? Colors.green[50] : Colors.red[50],
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.greyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.greyColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.more_horiz), onPressed: () {}),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("TOTAL PEDIDO",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.greyColor,
                            fontWeight: FontWeight.w600)),
                    Text(
                      amount,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ARTÍCULOS",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.greyColor,
                            fontWeight: FontWeight.w600)),
                    Text(
                      articles,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const SizedBox(width: 60),
                Column(children: [
                  Text(
                    daysAgo,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.greyColor, fontWeight: FontWeight.w500),
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
