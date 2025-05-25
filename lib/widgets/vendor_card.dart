import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/models/seller_model.dart';

class VendorCard extends StatelessWidget {
  final Seller seller;

  const VendorCard({
    required this.seller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String direction = seller.direc1;
    // if (direction.length > 10) {
    //   direction = '${direction.substring(0, 10)}...';
    // }

    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vendor Info Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'VENDEDOR',
                        style: TextStyle(
                            color: AppTheme.greyColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        seller.codigo,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Text(
                        seller.descripcion,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      if (seller.telefonos.isNotEmpty)
                        Text(
                          seller.telefonos,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.greyColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      if (seller.telefonos.isNotEmpty) const SizedBox(height: 4),
                      Text(
                        direction,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppTheme.greyColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  color: Colors.white,
                  icon: const Icon(Icons.more_horiz, color: Colors.grey),
                  onSelected: (String value) {
                    
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        value: 'show',
                        child: Row(
                          children: [
                            Image.asset(
                                'assets/icons/solar_bill-check-linear.png',
                                width: 20,
                                height: 20),
                            const SizedBox(width: 8),
                            Text('Ver facturas',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppTheme.primaryColor)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'devolution',
                        child: Row(
                          children: [
                            Image.asset('assets/icons/Vector.png',
                                width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('Ver pedidos',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppTheme.primaryColor)),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
            const Divider(height: 24),
            // Vendor Details Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Saldo Deudor',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 16),
                    Text('Activo',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 8.0),
                    Text('US \$${seller.saldoDeudor}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.red)),
                    Switch(
                      value: !seller.inactivo,
                      onChanged: (value) {},
                      activeColor: Colors.green,
                    ),
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
