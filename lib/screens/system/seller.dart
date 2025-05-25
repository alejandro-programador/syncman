import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/models/seller_model.dart';
import 'package:syncman_new/providers/seller_provider.dart';
import 'package:syncman_new/screens/system/seller_detail.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/utils/network_utils.dart';
import 'package:syncman_new/widgets/notification.dart';
import 'package:syncman_new/widgets/vendor_card.dart';

class SellerView extends StatefulWidget {
  const SellerView({super.key});

  @override
  State<SellerView> createState() => _SellerViewState();
}

class _SellerViewState extends State<SellerView> {
  int selectedCategory = 0;
  late StreamSubscription<bool> _connectivitySubscription;
  bool _isOnline = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  // scroll
  final ScrollController _scrollController = ScrollController();

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
      context.read<SellersProvider>().loadSellers();
    });
    initConnectivity();
  }

  List<dynamic> filteredSellers() {
    final sellers = context.watch<SellersProvider>().sellers;
    List<dynamic> filteredList;

    switch (selectedCategory) {
      case 1:
        filteredList = sellers.where((client) => client['saldo_deudor'] > 0).toList();
        break;
      default:
        filteredList = sellers;
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((client) {
        String name = client['descripcion']?.toLowerCase() ?? '';
        String code = client['codigo']?.toLowerCase() ?? '';
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
    final sellerProvider = context.watch<SellersProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Vendedores", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Text("Hoy 09:25 AM",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(fontFamily: 'Mulish')),
          ],
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodySmall,
                labelStyle: Theme.of(context).textTheme.bodySmall,
                hintText: 'Buscar vendedor',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          // Tab Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = 0; // Esto debe ser un int, no un double
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedCategory == 0 ? Colors.blue : AppTheme.greyBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Todos',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: selectedCategory == 0 ? Colors.white : Colors.black)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedCategory == 1 ? Colors.blue : AppTheme.greyBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Morosos',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: selectedCategory == 1 ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Vendor List
          Expanded(
            child: sellerProvider.isLoading && sellerProvider.sellers.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredSellers().length,
                    // itemCount: sellerProvider.sellers.length +
                    //     (sellerProvider.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < sellerProvider.sellers.length) {
                        final sellerData = filteredSellers()[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SellerDetailView(sellerDNI: sellerData['cedula'])),
                            );
                          },
                          child: VendorCard(
                            seller: sellerData,
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
    );
  }
}