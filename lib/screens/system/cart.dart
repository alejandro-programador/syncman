import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncman_new/models/configuration_model.dart';
import 'package:syncman_new/providers/cart_provider.dart';
import 'package:syncman_new/providers/client_provider.dart';
import 'package:syncman_new/providers/configuration_provider.dart';
import 'package:syncman_new/providers/order_provider.dart';
import 'package:syncman_new/providers/payment_condition_provider.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/cart_product.dart';
import 'package:syncman_new/widgets/menu.dart';

import 'package:uuid/uuid.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // Selected payment method
  String? _selectedPaymentMethod;
  bool _isSwitchEnabled = true;
  var uuid = const Uuid();
  final TextEditingController _observacionController = TextEditingController();
  Map<int, double> productPrices = {};
  Map<int, String> selectedUnitIds = {};
  Map<int, String> calculatedPrices = {};
  double totalTax = 0.0;

  void updateTotal() {
    double total = productPrices.values.fold(0, (sum, price) => sum + price);
    context.read<CartProvider>().updateTotalBruto(total);
    calculateTotalTax();
  }

  void calculateTotalTax() {
    double taxSum = 0.0;
    final cartProvider = context.read<CartProvider>();
    for (var i = 0; i < cartProvider.cartItems.length; i++) {
      final price = productPrices[i] ?? 0.0;
      final taxRate = cartProvider.cartItems[i].taxRate;
      final taxAmount = (price * taxRate) / 100;
      taxSum += taxAmount;
    }
    setState(() {
      totalTax = taxSum;
    });
  }

  void handlePriceChange(int index, double price) {
    setState(() {
      productPrices[index] = price;
      updateTotal();
    });
  }

  void handleUnitChange(int index, String unitId) {
    setState(() {
      selectedUnitIds[index] = unitId;
    });
  }

  void handleCalculatedPriceChange(int index, String price) {
    setState(() {
      calculatedPrices[index] = price;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        // First fetch configuration from API
        await context.read<ConfigurationProvider>().fetchConfiguration();
        // Then load payment conditions
        await context.read<PaymentConditionProvider>().loadPaymentConditions();
        // Finally fetch cart
        await fetchCart();
      } catch (e) {
        print('Error initializing cart: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al cargar la configuración: $e'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  Future<void> fetchCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get client ID
    String clientID = prefs.getString('id_cliente_pedido') ?? '';
    if (mounted) {
      final clientProvider = Provider.of<ClientsProvider>(context, listen: false);
      await clientProvider.fetchClientCart(clientID);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final clientData = cartProvider.client;
    final paymentMethods = context.watch<PaymentConditionProvider>().paymentconditions;
    final totalBruto = cartProvider.totalBruto;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          children: [
            Text(
              "Carrito",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.visibility, color: Colors.black),
            onPressed: () {},
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuView()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppTheme.greyBackground,
          margin: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Client Section
              Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CLIENTE',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Text(clientData['code'] ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      Text(clientData['name'] ?? '', style: Theme.of(context).textTheme.bodySmall),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total artículos',
                                  style: Theme.of(context).textTheme.labelMedium),
                              const SizedBox(height: 4),
                              Text('Total', style: Theme.of(context).textTheme.labelMedium),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(cartProvider.cartItems.length.toString(),
                                  style: Theme.of(context).textTheme.labelMedium),
                              const SizedBox(height: 4),
                              Text('\$${totalBruto.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.primaryColor, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Products Section
              Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PRODUCTOS',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16),
                      if (cartProvider.cartItems.isEmpty) const Text('No hay productos'),
                      if (cartProvider.cartItems.isNotEmpty)
                        ...cartProvider.cartItems.map((item) => CartProduct(
                          productName: item.productName,
                          productCode: item.productCode,
                          stock: item.stock,
                          category: item.category,
                          taxRate: item.taxRate,
                          unidades: item.unidades,
                          pricePerPackage: "US\$ 0.00 /01", // Default value since we don't store prices
                          pricePerUnit: "US\$ 0.00 /01", // Default value since we don't store prices
                          unitPrice: 0.0, // Default value since we don't store prices
                          onRemove: () {
                            // TODO: Implement remove functionality
                          },
                          onPriceChanged: (price) {
                            // TODO: Implement price change functionality
                          },
                          onUnitChanged: (unit) {
                            // TODO: Implement unit change functionality
                          },
                          onCalculatedPriceChanged: (price) {
                            // TODO: Implement calculated price change functionality
                          },
                        )).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
