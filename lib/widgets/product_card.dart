import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncman_new/providers/article_provider.dart';
import 'package:syncman_new/providers/client_provider.dart';
import 'package:syncman_new/providers/cart_provider.dart';
import 'package:syncman_new/theme/theme.dart';

class ProductCard extends StatefulWidget {
  final String productName;
  final String productID;
  final String productCode;
  final String pricePerPackage;
  final String pricePerUnit;
  final String category;
  final String subcategory;
  final int stock;
  final List<dynamic> unidades; // Changed from List<Map<String, dynamic>>
  final List<dynamic> fullPrices;
  final double priceByUnit;
  final bool? hideAddButton;
  final String tipoImp;
  final double screenWidth;
  final int taxRate;

  const ProductCard({
    super.key,
    required this.productName,
    required this.productID,
    required this.productCode,
    required this.pricePerPackage,
    required this.pricePerUnit,
    required this.category,
    required this.subcategory,
    required this.stock,
    required this.unidades,
    required this.fullPrices,
    required this.priceByUnit,
    required this.tipoImp,
    required this.screenWidth,
    required this.taxRate,
    this.hideAddButton = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 1;

  List<Map<String, dynamic>> _convertUnidades() {
    return widget.unidades.map((unit) {
      if (unit is Map<String, dynamic>) {
        return unit;
      } else if (unit is String) {
        try {
          return jsonDecode(unit) as Map<String, dynamic>;
        } catch (e) {
          return {'_id': '', 'unidadName': ''};
        }
      } else {
        return {'_id': '', 'unidadName': ''};
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final articlesProvider = context.watch<ArticleProvider>();
    // String selectedPrice = widget.fullPrices.isNotEmpty
    //     ? widget.fullPrices[0]['monto'].toString()
    //     : '\$1000'; // Default price if empty
    // List<String> priceOptions = ['\$1000', '\$1500', '\$2000'];
    // String selectedUnit = "";

    // Calculate max length based on screen width
    int maxLength = widget.screenWidth > 600
        ? 50
        : widget.screenWidth > 400
            ? 40
            : widget.screenWidth > 360
                ? 32
                : 24;

    String truncatedName = widget.productName.length > maxLength
        ? "${widget.productName.substring(0, maxLength)}..."
        : widget.productName;

    bool productExists(String productCode, List<dynamic> clientCart) {
      return clientCart.any((product) => product['productCode'] == productCode);
    }

    // Convert unidades to the correct type
    final convertedUnidades = _convertUnidades();

    Future<String> saveClientID() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String clientID = prefs.getString('id_cliente_pedido') ?? '';
      return clientID;
    }

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset("assets/images/product.png", width: 58, height: 46),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/product-detail");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.productCode,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: AppTheme.greyColor),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        truncatedName,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                      if (articlesProvider.brandType == "brand")
                        Text(
                          widget.category,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w500),
                        ),
                      if (articlesProvider.brandType == "sub_brand")
                        Text(
                          widget.subcategory,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w500),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const Column(
                  children: [
                    Icon(
                      Icons.arrow_right,
                      color: AppTheme.greyColor,
                      size: 24,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    size: 24,
                    color: AppTheme.greyColor,
                  ),
                ),
                Text(
                  quantity.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                IconButton(
                  onPressed: () {
                    if (quantity < widget.stock) {
                      setState(() {
                        quantity++;
                      });
                    }
                  },
                  icon:
                      const Icon(Icons.add_circle_outline, size: 24, color: AppTheme.primaryColor),
                ),
                const Spacer(),
                Flexible(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                    onPressed: () {},
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("/",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w600, color: AppTheme.primaryColor)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                if (widget.hideAddButton != true)
                  Flexible(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                      onPressed: () async {
                        // Save client ID
                        final clientID = await saveClientID();

                        print('ID DEL CLIENTE: $clientID');

                        // Save product to local db

                        // save product to provider
                        final cartProvider = Provider.of<CartProvider>(context, listen: false);

                        await cartProvider.addProductToCart({
                          'client_id': clientID,
                          'productID': widget.productID,
                          'productName': widget.productName,
                          'productCode': widget.productCode,
                          'category': widget.category,
                          'stock': widget.stock,
                          'unidades': convertedUnidades,
                          'quantity': quantity,
                          'tipoImp': widget.tipoImp,
                          'taxRate': widget.taxRate,
                        });

                        // Show success message
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Producto añadido al carrito'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text("Añadir",
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600, color: AppTheme.primaryColor)),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
