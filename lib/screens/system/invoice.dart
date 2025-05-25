import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class InvoiceView extends StatelessWidget {
  const InvoiceView({super.key});

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
            Text(
              "Previsualización",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client Information
            Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CLIENTE',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'J-123456 7',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Text('Juan Perez'),
                        const SizedBox(height: 8),
                      ],
                    ),
                    const Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.shopping_cart, color: Colors.blue),
                            SizedBox(width: 4),
                            Text(
                              '10',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 2, color: AppTheme.greyBackground),
            // Cart Items
            Expanded(
              child: ListView(
                children: [
                  _buildCartItem(
                    context,
                    code: '1023040',
                    article: 'Batería 24RF Fulgor 800 AMP',
                    unit: 'Unidad',
                    quantity: 2,
                    total: 280.00,
                  ),
                  _buildCartItem(
                    context,
                    code: '1023040',
                    article: 'Batería 24RF Fulgor 800 AMP',
                    unit: 'Unidad',
                    quantity: 1,
                    total: 140.00,
                  ),
                  _buildCartItem(
                    context,
                    code: '1023040',
                    article: 'Batería 24RF Fulgor 800 AMP',
                    unit: 'Unidad',
                    quantity: 3,
                    total: 420.00,
                  ),
                ],
              ),
            ),
            // Total Section
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '\$840.00',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w700, color: AppTheme.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(
    BuildContext context, {
    required String code,
    required String article,
    required String unit,
    required int quantity,
    required double total,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Código',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppTheme.greyColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Artículo',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppTheme.greyColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Unidad',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppTheme.greyColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cantidad',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppTheme.greyColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppTheme.greyColor),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(code, style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 8),
                  Text(article, style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 8),
                  Text(unit, style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 8),
                  Text('$quantity', style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 8),
                  Text(
                    '\$$total',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
