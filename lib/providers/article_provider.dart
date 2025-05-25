import 'package:flutter/material.dart';
import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/database/app_database.dart';
import 'package:syncman_new/models/article_model.dart';
import 'package:syncman_new/providers/price_provider.dart';
import 'package:syncman_new/services/sync/category_service.dart';
import 'package:syncman_new/utils/network_utils.dart';
import 'package:syncman_new/config/pagination_config.dart';
import 'package:syncman_new/services/sync/article_service.dart';

class ArticleProvider with ChangeNotifier {
  final ArticleService _articleService;
  BuildContext? _context;
  List<Articulo> _articles = [];
  final List<dynamic> _articlesWithoutStock = [];
  final List<dynamic> _articlesWithStock = [];
  List<dynamic> _stockList = [];
  List<dynamic> _unitList = [];
  Map<String, dynamic> _articleDetail = {};
  String _brandType = 'brand';
  int _stockFilter = 0;
  bool _isLoading = false;
  String _errorMessage = '';

  List<Articulo> get articles => _articles;
  List<dynamic> get articlesWithoutStock => _articlesWithoutStock;
  List<dynamic> get articlesWithStock => _articlesWithStock;
  List<dynamic> get stockList => _stockList;
  List<dynamic> get unitList => _unitList;
  bool get isLoading => _isLoading;
  Map<String, dynamic> get articleDetail => _articleDetail;
  String get brandType => _brandType;
  int get stockFilter => _stockFilter;
  String get errorMessage => _errorMessage;

  ArticleProvider(this._articleService);

  void setContext(BuildContext context) {
    _context = context;
  }

  BuildContext get context {
    if (_context == null) {
      throw Exception('Context not set. Call setContext first.');
    }
    return _context!;
  }

  Future<void> changeBrandType(String value) async {
    _brandType = value;
    notifyListeners();
  }

  void setStockFilter(int value) {
    _stockFilter = value;
    notifyListeners();
  }

  // Future<void> fetchArticleData(String articleCode) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     final response = await ApiService().getRequest('/articulos/$articleCode');
  //     if (response != null && response.statusCode == 200) {
  //       _articleDetail = response.data;
  //       notifyListeners();
  //     } else {
  //       throw Exception('Error al obtener el artículo. status: $response');
  //     }
  //   } catch (e) {
  //     throw Exception('Error al obtener el artículo: $e');
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }

  // Obtener datos desde la base local
  // Future<void> loadStockAlmacenes() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   final stockList = await _articleService.query();
  //   _stockList = stockList;

  //   _isLoading = false;
  //   notifyListeners();
  // }

  // Future<List> getStockAlmacenes({bool? loadDatabase = false}) async {
  //   if (loadDatabase == true) {
  //     await loadStockFromDatabase();
  //     return [];
  //   }

  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     int page = PaginationConfig.defaultPage;
  //     bool hasMoreData = true;

  //     while (hasMoreData) {
  //       final response = await ApiService()
  //           .getRequest('/stock-almacenes?page=$page&size=${PaginationConfig.defaultPageSize}');

  //       if (response != null && response.statusCode == 200) {
  //         final data = response.data;

  //         if (data is List && data.isNotEmpty) {
  //           for (var stock in data) {
  //             Stock stockSelected = Stock.fromJson(stock);
  //             await _articleService.updateOrCreate(stockSelected);
  //           }

  //           page++;
  //         } else {
  //           hasMoreData = false;
  //         }
  //       } else {
  //         hasMoreData = false;
  //       }
  //     }

  //     await loadStockFromDatabase();
  //     return [];
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<List> getUnidades({bool? loadDatabase = false}) async {
  //   if (loadDatabase == true) {
  //     await loadUnitFromDatabase();
  //     return [];
  //   }

  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     List<Map<String, dynamic>> localUnidades = await _articleService.queryAllUnits();

  //     if (localUnidades.isNotEmpty) {
  //       await loadUnitFromDatabase();
  //     } else {
  //       if (await NetworkUtils.hasInternetConnection()) {
  //         int page = PaginationConfig.defaultPage;
  //         bool hasMoreData = true;

  //         while (hasMoreData) {
  //           final response = await ApiService()
  //               .getRequest('/unidades?page=$page&size=${PaginationConfig.defaultPageSize}');

  //           if (response != null && response.statusCode == 200) {
  //             final List<dynamic> data = response.data;

  //             if (data.isNotEmpty) {
  //               for (var unit in data) {
  //                 Unidad unitSelected = Unidad.fromJson(unit);
  //                 await _articleService.updateOrCreate(unitSelected);
  //               }

  //               page++;
  //             } else {
  //               hasMoreData = false;
  //             }
  //           } else {
  //             hasMoreData = false;
  //           }
  //         }

  //         await loadUnitFromDatabase();
  //       } else {
  //         _unitList = await _articleService.queryAllUnits();
  //       }
  //     }
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }

  //   return [];
  // }

  // Future<String> getUnidadName(String unidadID) async {
  //   try {
  //     // Buscar la unidad en _unitList filtrando por unidadID
  //     final unidad = _unitList.firstWhere(
  //       (unit) => unit['_id'] == unidadID,
  //       orElse: () => {},
  //     );

  //     // Retornar la descripción si se encuentra la unidad, de lo contrario, "N/A"
  //     return unidad.isNotEmpty ? unidad['descripcion'] ?? "N/A" : "N/A";
  //   } catch (e) {
  //     return "N/A";
  //   }
  // }

  List<dynamic> removeDuplicates(List<dynamic> data) {
    Set<String> seen = {};
    return data.where((item) => seen.add(item['articulo'])).toList();
  }

  Future<List<Map<String, dynamic>>> getUnidadList(List unidades, int stock) async {
    try {
      final List<Map<String, dynamic>> unidadesList = [];

      for (var unidad in unidades) {
        final unidadName = unidad.unidad.descripcion; // * Test
        final int equivalencia = unidad.equivalencia; // * Test

        unidadesList.add({
          '_id': unidad.unidad.id,
          'unidadName': unidadName,
          'equivalencia': equivalencia,
          'stock': (stock > 0) ? stock / equivalencia : 0,
          'inversa': unidad.inversa,
          'updatedAt': unidad.updatedAt
        });
      }

      return unidadesList;
    } catch (e) {
      return [];
    }
  }

  Future<int> getProductStock(String productID) async {
    try {
      // Buscar el producto en la lista local _stockList
      final stockItem = _stockList.firstWhere(
        (item) => item['articulo'] == productID,
        orElse: () => null,
      );

      // Si se encuentra, devolver el stock, de lo contrario, devolver 0
      return stockItem != null ? stockItem['stock'] ?? 0 : 0;
    } catch (e) {
      return 0;
    }
  }

  Future<List<dynamic>> getProductPrices(
    List<dynamic> priceList,
    String productID,
    String updatedAt,
  ) async {
    try {
      // Filtrar precios que coinciden con el ID del producto y su updatedAt
      final filteredPrices = priceList
          .where((price) {
            final articulo = price['articulo'];
            final update = price['updatedAt'];
            return articulo == productID && update == updatedAt;
          })
          .map((price) => Map<String, dynamic>.from(price))
          .toList();

      // Remover duplicados (implementación tuya)
      final cleanPriceList = removeDuplicates(filteredPrices);

      return cleanPriceList;
    } catch (e) {
      return [];
    }
  }

  Future<String> getPriceName(String priceTypeID, List<dynamic> priceTypeList) async {
    try {
      final priceType = priceTypeList.firstWhere(
        (type) => type['id'] == priceTypeID,
        orElse: () => {},
      );

      return priceType.isNotEmpty ? priceType['descripcion'] ?? "N/A" : "N/A";
    } catch (e) {
      return "";
    }
  }

  Map<String, Map<String, dynamic>> getLatestUniqueUnits(
      List<Map<String, dynamic>> unidadNameList) {
    final Map<String, Map<String, dynamic>> uniqueUnits = {};

    for (var unidad in unidadNameList) {
      final unidadName = unidad['unidadName'];
      final updatedAt = unidad['updatedAt'];

      if (!uniqueUnits.containsKey(unidadName) ||
          updatedAt.compareTo(uniqueUnits[unidadName]!['updatedAt']) > 0) {
        uniqueUnits[unidadName] = unidad;
      }
    }

    return uniqueUnits;
  }

  Future<List<Map<String, dynamic>>> getFilteredProductPrices({
    required List<dynamic> allPrices,
    required List<dynamic> priceTypeList,
    required String productId,
    required String updatedAt,
  }) async {
    // Obtener los precios del producto filtrado
    final productPrices = await getProductPrices(
      allPrices,
      productId,
      updatedAt,
    );

    // Transformar y limpiar la lista
    final filteredPriceList = await Future.wait(productPrices.map((price) async {
      final String priceType = price['tipoPrecio'];
      final double amount = (price['monto'] as num).toDouble();

      final String priceTypeName = await getPriceName(
        priceType,
        priceTypeList,
      );

      return {
        'monto': amount,
        'nombreTipoPrecio': priceTypeName,
        'idTipoPrecio': priceType,
      };
    }).toList());

    return filteredPriceList;
  }

  double calculateBestPrice(
    List<Map<String, dynamic>> units,
    List<Map<String, dynamic>> prices,
  ) {
    double calculatedPrice = 0;

    for (var unidad in units) {
      final double equivalencia = (unidad['equivalencia'] as num).toDouble();
      final bool inversa = unidad['inversa'] == true;

      if (equivalencia <= 0) continue;

      for (var price in prices) {
        final double monto = (price['monto'] as num).toDouble();
        if (monto <= 0) continue;

        double tempPrice = inversa ? monto * equivalencia : monto / equivalencia;

        // Guardar el primer precio válido o el menor
        if (calculatedPrice == 0 || tempPrice < calculatedPrice) {
          calculatedPrice = tempPrice;
        }
      }
    }

    return calculatedPrice;
  }

  // Future<dynamic> getFullArticles(List<dynamic> data, PriceProvider priceProvider) async {
  //   List<dynamic> fullArticleList = [];

  //   // stop if data is empty
  //   if (data.isEmpty) {
  //     _isLoading = false;
  //     notifyListeners();
  //     return [];
  //   }

  //   for (var article in data) {
  //     // Convert the article to a Map<String, dynamic>
  //     Map<String, dynamic> articleMap = Map<String, dynamic>.from(article);

  //     Articulo articleSelected = Articulo.fromJson(articleMap);

  //     // Fetch stock
  //     final int stock = await getProductStock(articleSelected.id);

  //     // Get Unidad

  //     final List<Map<String, dynamic>> unidadNameList =
  //         await getUnidadList(articleSelected.unidades, stock);

  //     // Get last updated unit
  //     final uniqueUnits = getLatestUniqueUnits(unidadNameList);
  //     List<Map<String, dynamic>> cleanNameList = uniqueUnits.values.toList();

  //     // Get prices
  //     final filteredPriceList = await getFilteredProductPrices(
  //       allPrices: priceProvider.prices,
  //       priceTypeList: priceProvider.priceTypeList,
  //       productId: articleSelected.id,
  //       updatedAt: articleSelected.updatedAt,
  //     );

  //     // Calculate price
  //     final double calculatedPrice = calculateBestPrice(cleanNameList, filteredPriceList);

  //     // Get tax rate from impuestos table
  //     int taxRate = 0;
  //     if (articleSelected.tipoImp.isNotEmpty) {
  //       final db = await AppDatabase.instance.database;
  //       final List<Map<String, dynamic>> taxResults = await db.query(
  //         'impuestos',
  //         where: 'tipoImpuesto = ?',
  //         whereArgs: [articleSelected.tipoImp],
  //       );

  //       if (taxResults.isNotEmpty) {
  //         taxRate = taxResults.first['porcTasa'] ?? 0;
  //       }
  //     }

  //     // Create a new map with all the data
  //     Map<String, dynamic> enrichedArticle = Map<String, dynamic>.from(articleMap);
  //     enrichedArticle['unidadNameList'] = cleanNameList;
  //     enrichedArticle['prices'] = filteredPriceList;
  //     enrichedArticle['stock'] = stock;
  //     enrichedArticle['precio'] = calculatedPrice;
  //     enrichedArticle['taxRate'] = taxRate;

  //     fullArticleList.add(enrichedArticle);

  //     if (stock == 0) {
  //       _articlesWithoutStock.add(enrichedArticle);
  //     } else if (stock >= 1) {
  //       _articlesWithStock.add(enrichedArticle);
  //     }
  //   }

  //   return fullArticleList;
  // }

  Future<void> loadArticles() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      print('=== Loading Articles from Database ===');
      final articlesList = await _articleService.query();
      _articles = articlesList;
      
      print('=== Articles Loaded ===');
      print('Total articles loaded: ${_articles.length}');
      for (var article in _articles) {
        print('Article: ${article.descripcion}');
        print('ID: ${article.id}');
        print('Código: ${article.codigo}');
        print('Stock: ${article.stock}');
        print('Precio: ${article.precio}');
        print('------------------------');
      }
    } catch (e) {
      print('Error loading articles: $e');
      _errorMessage = 'Error loading articles: $e';
      _articles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> fetchArticles(PriceProvider priceProvider) async {
  //   if (_isLoading) return; // Prevent multiple requests
  //   _isLoading = true;
  //   notifyListeners();

  //   if (await NetworkUtils.hasInternetConnection()) {
  //     int page = PaginationConfig.defaultPage;
  //     bool hasMoreData = true;

  //     while (hasMoreData) {
  //       final articles = await _articleService.query(page: page);
  //       if (articles.isNotEmpty) {
  //         for (var article in articles) {
  //           await _articleService.updateOrCreate(article);
  //         }
  //         page++;
  //       } else {
  //         hasMoreData = false;
  //       }
  //     }

  //     await loadArticlesFromDatabase();
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }

  // Obtener datos desde la base local
  Future<void> loadUnits() async {
    _isLoading = true;
    notifyListeners();

    final unitsList = await _articleService.query();
    _unitList = unitsList;

    _isLoading = false;
    notifyListeners();
  }

  // Future<void> loadUnitFromDatabase() async {
  //   try {
  //     final unitList = await _articleService.queryAllUnits();

  //     _unitList = unitList;

  //     // _unitList = unitList
  //     //     .map((unit) => {
  //     //           '_id': unit['_id'],
  //     //           'codigo': unit['codigo'],
  //     //           'descripcion': unit['descripcion'],
  //     //           'datosAdicionales': jsonDecode(
  //     //               unit['datosAdicionales'] ?? '{}'), // Decodificar JSON
  //     //         })
  //     //     .toList();

  //     notifyListeners();
  //   } catch (e) {
  //     throw Exception('Error al cargar unidades desde la base de datos: $e');
  //   }
  // }

  // Future<void> loadStockFromDatabase() async {
  //   try {
  //     final stocksList = await _articleService.queryAllStock();

  //     _stockList = stocksList;

  //     notifyListeners();
  //   } catch (e) {
  //     throw Exception('Error al cargar artículos desde la base de datos: $e');
  //   }
  // }

  // Future<void> loadArticlesFromDatabase() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     _articles = await _articleService.query();
  //   } catch (e) {
  //     _articles = [];
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> loadCategoriesFromDatabase() async {
  //   try {
  //     final categoriesList = await _categoryService.query();

  //     // Convertir cada categoría a Map<String, dynamic>
  //     final List<Map<String, dynamic>> decodedCategories = categoriesList.map((category) {
  //       final Map<String, dynamic> decodedCategory = Map<String, dynamic>.from(category);

  //       // Decodificar campos JSON si es necesario
  //       if (category['datosAdicionales'] != null) {
  //         decodedCategory['datosAdicionales'] = jsonDecode(category['datosAdicionales']);
  //       }

  //       return decodedCategory;
  //     }).toList();

  //     // Actualizar las categorías en el provider
  //     final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
  //     categoryProvider.updateCategories(decodedCategories);
  //   } catch (e) {
  //     throw Exception('Error al cargar categorías desde la base de datos: $e');
  //   }
  // }

  // Future<void> loadSubcategoriesFromDatabase() async {
  //   try {
  //     final subcategoriesList = await _articleService.queryAllSubcategories();

  //     // Convertir cada subcategoría a Map<String, dynamic>
  //     final List<Map<String, dynamic>> decodedSubcategories = subcategoriesList.map((subcategory) {
  //       final Map<String, dynamic> decodedSubcategory = Map<String, dynamic>.from(subcategory);

  //       // Decodificar campos JSON si es necesario
  //       if (subcategory['datosAdicionales'] != null) {
  //         decodedSubcategory['datosAdicionales'] = jsonDecode(subcategory['datosAdicionales']);
  //       }

  //       return decodedSubcategory;
  //     }).toList();

  //     // Actualizar las subcategorías en el provider
  //     final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
  //     categoryProvider.updateSubcategories(decodedSubcategories);
  //   } catch (e) {
  //     throw Exception('Error al cargar subcategorías desde la base de datos: $e');
  //   }
  // }

  // Future<void> loadAllData() async {
  //   await Future.wait([
  //     loadArticlesFromDatabase(),
  //     // loadCategoriesFromDatabase(), // * FIX
  //     // loadSubcategoriesFromDatabase(), // * FIX
  //   ]);
  // }

  Future<Articulo?> getArticleById(String id) async {
    try {
      return await _articleService.getById(id);
    } catch (e) {
      _errorMessage = 'Error getting article: $e';
      notifyListeners();
      return null;
    }
  }

  Future<Articulo?> getArticleByCodigo(String codigo) async {
    try {
      return await _articleService.getByCodigo(codigo);
    } catch (e) {
      _errorMessage = 'Error getting article: $e';
      notifyListeners();
      return null;
    }
  }
}
