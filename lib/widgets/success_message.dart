import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class SuccessMessageView extends StatefulWidget {
  final String? title;
  final String? type;
  final String? headerTitle;
  final bool? showPreview;

  const SuccessMessageView(
      {super.key, this.title, this.type, this.headerTitle, this.showPreview});
  @override
  State<SuccessMessageView> createState() => _SuccessMessageViewState();
}

class _SuccessMessageViewState extends State<SuccessMessageView> {
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
              widget.headerTitle ?? "Previsualización",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
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
        child: Container(
          margin: const EdgeInsets.all(8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.showPreview == true)
                Card(
                    color: Colors.white,
                    elevation: 0,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/Illustration_icon.png',
                                  width: 80, height: 80),
                              Text.rich(
                                TextSpan(
                                  text: (widget.type == 'cobro')
                                      ? 'Cobro Nro'
                                      : 'Pedido Nro ',
                                  style: Theme.of(context).textTheme.bodySmall,
                                  children: [
                                    TextSpan(
                                      text: '#20049999',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                widget.title ?? 'Pedido creado con éxito',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.greenBackground),
                              )
                            ]))),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text.rich(
                      TextSpan(
                        text: (widget.type == 'cobro')
                            ? 'Cobro Nro'
                            : 'Pedido Nro ',
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(
                            text: '#20049999',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                                ?.copyWith(
                                    color: AppTheme.greyColor,
                                    fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'J-123456 7',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Text('Juan Perez'),
                          const SizedBox(height: 8),
                        ],
                      ),
                      if (widget.type != 'cobro')
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
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryColor),
                  ),
                ],
              ),
            ],
          ),
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
                  Text('$quantity',
                      style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 8),
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
