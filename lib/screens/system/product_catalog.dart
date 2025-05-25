import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/extensions/theme_extension.dart';
import 'package:syncman_new/providers/article_provider.dart';
import 'package:syncman_new/routes/routes.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/menu.dart';
import 'package:syncman_new/utils/network_utils.dart';
import 'package:syncman_new/widgets/notification.dart';

class ProductCatalogView extends StatefulWidget {
  const ProductCatalogView({super.key});

  @override
  State<ProductCatalogView> createState() => _ProductCatalogViewState();
}

class _ProductCatalogViewState extends State<ProductCatalogView> {
  bool isEmpty = false;
  int selectedCategory = 0;
  late StreamSubscription<bool> _connectivitySubscription;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool isLoadingInital = true;
  bool _isOnline = false;
  // String _categoryType = 'brand';

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
      // context.read<Produ>().loadProducts();
    });
    // Listen to search text changes
    _searchController.addListener(_onSearchChanged);
    initConnectivity();
  }

  Future<void> loadInitialData() async {
    // final categoryProvider = context.read<CategoryProvider>();
    // final articleProvider = context.read<ArticleProvider>();
    // final priceProvider = context.read<PriceProvider>();

    setState(() {
      isLoadingInital = false;
    });
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  // Function to filter articles based on category and search query
  List<dynamic> filteredArticles() {
    final articlesProvider = context.watch<ArticleProvider>();
    final articles = context.watch<ArticleProvider>().articles;
    final articlesWithoutStock = context.watch<ArticleProvider>().articlesWithoutStock;
    final articlesWithStock = context.watch<ArticleProvider>().articlesWithStock;

    List<dynamic> filteredList = articles;

    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((article) {
        String name = article['descripcion']?.toLowerCase() ?? '';
        String code = article['codigo']?.toLowerCase() ?? '';
        return name.contains(_searchQuery) || code.contains(_searchQuery);
      }).toList();
    }

    if (articlesProvider.stockFilter == 1) {
      return articlesWithStock;
    } else if (articlesProvider.stockFilter == 0) {
      return articlesWithoutStock;
    }
    return articles; // Mostrar todos los artículos si _stockFilter es -1
  }

  String getCategoryDescription(String articleCategoryId) {
    // final categories = context.read<CategoryProvider>().categories;

    // final category = categories.firstWhere(
    //   (cat) => cat['_id'] == articleCategoryId,
    //   orElse: () => {'descripcion': 'Sin categoría'},
    // );

    // return category['descripcion'];
    return '';
  }

  String getSubCategoryDescription(String articleSubcategoryId) {
    // final subcategories = context.read<CategoryProvider>().subcategories;

    // final subcategory = subcategories.firstWhere(
    //   (cat) => cat['_id'] == articleSubcategoryId,
    //   orElse: () => {'descripcion': 'Sin subcategoría'},
    // );

    // return subcategory['descripcion'];

    return '';
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
              child:
                  Image.asset('assets/icons/file-icons_microsoft-excel.png', width: 28, height: 28),
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
                    suffixIcon: GestureDetector(
                        onTap: () => _showFilterModal(context),
                        child: Image.asset('assets/icons/Group.png', width: 20, height: 20))),
              ),
            ),
            const SizedBox(height: 16),
            if (isEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Resultados de Abrazadera TMY',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            )), // Aligns to the left
                    Text(
                      '0 encontrados',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.primaryColor,
                          ),
                    ), // Aligns to the right
                  ],
                ),
              ),
            isEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // Ensures the content takes minimal vertical space
                        children: [
                          // Image at the top
                          Container(
                            color: Colors.white,
                            child: Image.asset(
                              'assets/images/box.png', // Replace with your image path
                              height: 150, // Set desired height
                            ),
                          ),

                          // Text directly below the image
                          const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Text(
                              'No encontrado',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                          ),

                          // Another text below the previous one
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: Text(
                              'No se encontraron artículos que coincidan con tu búsqueda.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: articlesProvider.articles.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppTheme.primaryColor,
                              ),
                            )
                          : ListView.builder(
                              itemCount: filteredArticles().length,
                              itemBuilder: (context, index) {
                                if (index < articlesProvider.articles.length) {
                                  // final article = filteredArticles()[index];
                                  // final categoryDescription =
                                  //     getCategoryDescription(article['categoria']);
                                  // final subcategoryDescription =
                                  //     getSubCategoryDescription(article['sublinea']);

                                  //   return GestureDetector(
                                  //     onTap: () {
                                  //       Navigator.pushNamed(
                                  //           context, Routes.productDetail);
                                  //     },
                                  //     child: ProductCard(
                                  //       productName: article['descripcion'] ??
                                  //           'Sin descripción',
                                  //       productID: article['_id'] ?? 'Sin ID',
                                  //       productCode:
                                  //           article['codigo'] ?? 'Sin código',
                                  //       category: categoryDescription,
                                  //       subcategory: subcategoryDescription,
                                  //       pricePerPackage: "US\$ 8.89 /01",
                                  //       pricePerUnit: "US\$ 8.89 /01",
                                  //       stock:
                                  //           article['stockPedido'] ?? 'Sin stock',
                                  //       unidades: article['unidadNameList'],
                                  //       fullPrices: article['prices'],
                                  //       priceByUnit: article['precio'],
                                  //       hideAddButton: true,
                                  //       tipoImp: article['tipoImp'],
                                  //     ),
                                  //   );
                                  // } else {
                                  //   return const Padding(
                                  //     padding: EdgeInsets.all(8.0),
                                  //     child: Center(
                                  //         child: CircularProgressIndicator()),
                                  //   );
                                }
                                return null;
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

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        final articlesProvider = context.watch<ArticleProvider>();

        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sort & View",
                      style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Text(
                  "Filtrar por",
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500, color: AppTheme.greyColor),
                ),
                ListTile(
                  title: const Text("Artículos en stock"),
                  selected: articlesProvider.stockFilter == 1,
                  leading: Radio<int>(
                    value: 1,
                    groupValue: articlesProvider.stockFilter,
                    onChanged: (value) {
                      articlesProvider.setStockFilter(value!);
                    },
                  ),
                  onTap: () {
                    articlesProvider.setStockFilter(1);
                  },
                ),
                ListTile(
                  title: const Text("Artículos sin stock"),
                  selected: articlesProvider.stockFilter == 0,
                  leading: Radio<int>(
                    value: 0,
                    groupValue: articlesProvider.stockFilter,
                    onChanged: (value) {
                      articlesProvider.setStockFilter(value!);
                    },
                  ),
                  onTap: () {
                    articlesProvider.setStockFilter(0);
                  },
                ),
                const Divider(),
                const Text(
                  "Mostrar por",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  selected: articlesProvider.brandType == "brand",
                  title: Text(
                    "Marca",
                    style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  leading: Radio(
                    value: "brand",
                    groupValue: articlesProvider.brandType,
                    onChanged: (value) {
                      articlesProvider.changeBrandType('brand');
                    },
                  ),
                ),
                ListTile(
                  selected: articlesProvider.brandType == "sub_brand",
                  title: Text(
                    "Sub marcas",
                    style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  leading: Radio(
                    value: "sub_brand",
                    groupValue: articlesProvider.brandType,
                    onChanged: (value) {
                      articlesProvider.changeBrandType('sub_brand');
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Aplicar cambios",
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      articlesProvider.changeBrandType("brand");
                      articlesProvider.setStockFilter(1);
                    },
                    child: Text(
                      "Restaurar por defecto",
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500, color: AppTheme.greyColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
