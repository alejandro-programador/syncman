import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/models/order_model.dart';
import 'package:syncman_new/providers/order_provider.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/utils/network_utils.dart';
import 'package:syncman_new/widgets/menu.dart';
import 'package:syncman_new/widgets/notification.dart';
import 'package:syncman_new/widgets/payment_card.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int selectedCategory = 0;
  late StreamSubscription<bool> _connectivitySubscription;
  // final TextEditingController _searchController = TextEditingController();
  final String _searchQuery = "";
  bool _isOnline = false;

  void initConnectivity() {
    NetworkUtils.startConnectivityCheck();
    _connectivitySubscription = NetworkUtils.onConnectivityChanged.listen((isOnline) {
      setState(() {
        _isOnline = isOnline;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().loadOrders();
    });
    initConnectivity();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    NetworkUtils.stopConnectivityCheck();
    super.dispose();
  }

  List<dynamic> filteredOrders() {
    final orders = context.watch<OrderProvider>().orders;
    List<dynamic> filteredList;

    // Filtrar por categoría seleccionada
    switch (selectedCategory) {
      case 1: // Moroso
        filteredList = orders.where((order) => order.saldo > 0).toList();
        break;
      case 2: // Al día
        filteredList = orders.where((order) => order.saldo <= 0).toList();
        break;
      default: // Todos
        filteredList = orders;
    }

    // Aplicar búsqueda
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((order) {
        String name = order.descripcion.toLowerCase();
        String code = order.codigo.toLowerCase();
        return name.contains(_searchQuery) || code.contains(_searchQuery);
      }).toList();
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Pedidos", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/refresh.png', width: 12, height: 14),
                const SizedBox(width: 4),
                Text("Hoy 09:25 AM",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontFamily: 'Mulish')),
              ],
            )
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuView()),
            );
          },
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
      body: Container(
        color: AppTheme.greyBackground,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 18),
                  hintText: 'Buscar orden',
                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.greyColor,
                      ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ChoiceChip(
                      showCheckmark: false,
                      onSelected: (bool value) {},
                      selected: true,
                      color: const WidgetStatePropertyAll(AppTheme.primaryColor),
                      backgroundColor: AppTheme.primaryColor,
                      label: Text("Todos",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              )),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.transparent), // Elimina el borde
                        borderRadius: BorderRadius.circular(8), // Opcional: Ajusta la forma
                      ),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      showCheckmark: false,
                      label: Text("Creados",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              )),
                      onSelected: (bool value) {},
                      selected: false,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.transparent), // Elimina el borde
                        borderRadius: BorderRadius.circular(8), // Opcional: Ajusta la forma
                      ),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      showCheckmark: false,
                      label: Text("Parciales",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              )),
                      selected: false,
                      onSelected: (bool value) {},
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.transparent), // Elimina el borde
                        borderRadius: BorderRadius.circular(8), // Opcional: Ajusta la forma
                      ),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      showCheckmark: false,
                      label: Text("Procesados",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              )),
                      onSelected: (bool value) {},
                      selected: false,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.transparent), // Elimina el borde
                        borderRadius: BorderRadius.circular(8), // Opcional: Ajusta la forma
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: filteredOrders().length,
                itemBuilder: (context, index) {
                  if (index < orderProvider.orders.length) {
                    final order = filteredOrders()[index];

                    int totalProducts = 0;
                    for (var article in order.renglones) {
                      totalProducts += int.parse(article.totalArt.toString());
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/order-profile");
                      },
                      child: Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Image.asset('assets/icons/description.png', width: 40, height: 40),
                              ],
                            ),
                            Column(
                              children: [
                                PaymentCard(
                                  title: order.codigo,
                                  description: order.descripcion,
                                  amount: order.totalNeto.toString(),
                                  articles: totalProducts.toString(),
                                  isRecent: false,
                                  daysAgo: order.fecEmis.toString(),
                                  customIcon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.grey,
                                  ),
                                  clientName: order.cliente,
                                  client: {'id': order.cliente},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
