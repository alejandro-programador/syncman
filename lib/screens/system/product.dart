import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/extensions/theme_extension.dart';
import 'package:syncman_new/models/article_model.dart';
import 'package:syncman_new/providers/article_provider.dart';
import 'package:syncman_new/routes/routes.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/menu.dart';
import 'package:syncman_new/widgets/product_card.dart';
import 'package:syncman_new/utils/network_utils.dart';
import 'package:syncman_new/widgets/notification.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  bool isEmpty = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  late StreamSubscription<bool> _connectivitySubscription;
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
    _searchController.addListener(_onSearchChanged);
    initConnectivity();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('=== Initializing Product List View ===');
      _loadArticles();
    });
  }

  void _loadArticles() {
    print('=== Loading Articles ===');
    context.read<ArticleProvider>().loadArticles();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  List<Articulo> filteredArticles() {
    final articlesProvider = context.watch<ArticleProvider>();
    List<Articulo> filteredList = articlesProvider.articles;

    print('=== Filtering Articles ===');
    print('Total articles before filter: ${filteredList.length}');

    // Filtrar por búsqueda
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((article) {
        String name = article.descripcion.toLowerCase();
        String code = article.codigo.toLowerCase();
        return name.contains(_searchQuery) || code.contains(_searchQuery);
      }).toList();
      print('Articles after search filter: ${filteredList.length}');
    }

    return filteredList;
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.removeListener(_onSearchChanged);
    _connectivitySubscription.cancel();
    NetworkUtils.stopConnectivityCheck();
  }

  @override
  Widget build(BuildContext context) {
    final articlesProvider = context.watch<ArticleProvider>();
    final articles = filteredArticles();

    print('=== Building Product List View ===');
    print('Total articles to display: ${articles.length}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Artículos", style: TextStyle(fontSize: 18)),
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
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset('assets/icons/file-icons_microsoft-excel.png', width: 28, height: 28),
            ),
          )
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 18),
                  hintText: 'Buscar artículos',
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
            const SizedBox(height: 16),
            if (_searchQuery.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Resultados de búsqueda',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                    Text(
                      '${articles.length} encontrados',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: articlesProvider.isLoading && articlesProvider.articles.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        ),
                      )
                    : articlesProvider.articles.isEmpty
                        ? const Center(
                            child: Text('No hay artículos disponibles'),
                          )
                        : articles.isEmpty
                            ? const Center(
                                child: Text('No se encontraron artículos con los filtros seleccionados'),
                              )
                            : ListView.builder(
                                itemCount: articles.length,
                                itemBuilder: (context, index) {
                                  final article = articles[index];
                                  print('Building article card for: ${article.descripcion}');
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.productDetail);
                                    },
                                    child: ProductCard(
                                      productName: article.descripcion,
                                      productID: article.id,
                                      productCode: article.codigo,
                                      category: article.categoria.descripcion,
                                      subcategory: article.sublinea.descripcion,
                                      pricePerPackage: "US\$ ${article.precio ?? 0} /01",
                                      pricePerUnit: "US\$ ${article.precio ?? 0} /01",
                                      stock: article.stock ?? 0,
                                      unidades: article.unidades.map((u) => u.unidad.descripcion).toList(),
                                      fullPrices: [],
                                      priceByUnit: article.precio ?? 0.0,
                                      tipoImp: article.tipoImp,
                                      screenWidth: MediaQuery.of(context).size.width,
                                      taxRate: (article.taxRate ?? 0).toInt(),
                                    ),
                                  );
                                },
                              ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.cart);
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.shopping_cart_checkout, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
