import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/providers/bill_provider.dart';
import 'package:syncman_new/screens/system/bill_detail.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/utils/network_utils.dart';
import 'package:syncman_new/widgets/bill_card_model.dart';
import 'package:syncman_new/widgets/notification.dart';

class BillsView extends StatefulWidget {
  const BillsView({super.key});

  @override
  State<BillsView> createState() => _BillsViewState();
}

class _BillsViewState extends State<BillsView> {
  int selectedCategory = 0;
  late StreamSubscription<bool> _connectivitySubscription;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  // scroll
  final ScrollController _scrollController = ScrollController();

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
      context.read<BillProvider>().loadBills();
    });
    initConnectivity();
  }

  List<Bill> filteredBills() {
    final bills = context.watch<BillProvider>().bills;
    List<Bill> filteredList;

    // Filtrar por categoría seleccionada
    switch (selectedCategory) {
      case 0: // Sin pagar
        filteredList = bills.where((bill) => bill.saldo > 0).toList();
        break;
      case 1: // Pagas
        filteredList = bills.where((bill) => bill.saldo <= 0).toList();
        break;
      default: // Todos
        filteredList = bills;
    }

    // Aplicar búsqueda
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((bill) {
        String name = bill.descripcion.toLowerCase();
        String code = bill.codigo.toLowerCase();
        return name.contains(_searchQuery) || code.contains(_searchQuery);
      }).toList();
    }

    return filteredList;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _connectivitySubscription.cancel();
    NetworkUtils.stopConnectivityCheck();
  }

  @override
  Widget build(BuildContext context) {
    final billsProvider = context.watch<BillProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Facturas", style: TextStyle(fontSize: 18)),
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
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 18),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchQuery = "";
                              _searchController.clear();
                            });
                          },
                        )
                      : null,
                  hintText: "Buscar factura",
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
              child: Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      showCheckmark: false,
                      selected: selectedCategory == 0,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedCategory = 0;
                        });
                      },
                      label: Center(
                        child: Text(
                          "Sin Pagar",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: selectedCategory == 0 ? Colors.white : Colors.black,
                              ),
                        ),
                      ),
                      selectedColor: AppTheme.primaryColor,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: ChoiceChip(
                      showCheckmark: false,
                      selected: selectedCategory == 1,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedCategory = 1;
                        });
                      },
                      label: Center(
                        child: Text(
                          "Pagas",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: selectedCategory == 1 ? Colors.white : Colors.black,
                              ),
                        ),
                      ),
                      selectedColor: AppTheme.primaryColor,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: billsProvider.isLoading && billsProvider.bills.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: filteredBills().length,
                      itemBuilder: (context, index) {
                        if (index < billsProvider.bills.length) {
                          final bill = filteredBills()[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => BillDetailView(billData: bill.toMap())),
                              // );
                            },
                            child: BillCardModel(
                              title: '#${bill.codigo}',
                              description: bill.descripcion,
                              location: bill.dirEnt,
                              amount: bill.saldo.toString(),
                              emissionDate: bill.fecEmis,
                              expirationDate: bill.fecVenc,
                              pending: bill.saldo > 0 ? 1 : 0,
                              billSelected: bill.toMap(),
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
