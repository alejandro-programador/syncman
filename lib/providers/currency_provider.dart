import 'package:flutter/material.dart';
import 'package:syncman_new/models/currency_model.dart';
import 'package:syncman_new/services/sync/currency_service.dart';

class CurrencyProvider with ChangeNotifier {
  // final AppDatabase _database;
  final CurrencyService _currencyService;
  List<Currency> _currencies = [];
  bool _isLoading = false;

  List<Currency> get currencies => _currencies;
  bool get isLoading => _isLoading;

  CurrencyProvider(this._currencyService);

  // Obtener datos desde la base local
  Future<void> loadCurrencies() async {
    _isLoading = true;
    notifyListeners();

    try {
      print('=== Loading Currencies ===');
      final currencyList = await _currencyService.query();
      print('Currencies loaded: ${currencyList.length}');
      
      if (currencyList.isEmpty) {
        print('No currencies found in database');
      } else {
        for (var currency in currencyList) {
          print('Currency: ${currency.nombre} (${currency.codigo})');
        }
      }
      
      _currencies = currencyList;
    } catch (e, stackTrace) {
      print('Error loading currencies: $e');
      print('Stack trace: $stackTrace');
      _currencies = []; // Reset currencies on error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> fetchCurrencies({bool? loadDatabase = false}) async {
  //   if (loadDatabase == true) {
  //     await loadCurrenciesFromDatabase();
  //     return;
  //   }
  //   if (_isLoading) return; // Prevent multiple requests
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     List<Map<String, dynamic>> localCurrencies = await _database.dbGetAll('monedas');

  //     if (await NetworkUtils.hasInternetConnection()) {
  //       int page = PaginationConfig.defaultPage;
  //       bool hasMoreData = true;

  //       while (hasMoreData) {
  //         final response = await ApiService()
  //             .getRequest('/monedas?page=$page&size=${PaginationConfig.defaultPageSize}');

  //         if (response != null && response.statusCode == 200) {
  //           final List<dynamic> data = response.data;

  //           if (data.isNotEmpty) {
  //             final localCurrencyCodes = localCurrencies.map((c) => c['codigo']).toSet();

  //             final newCurrencies = data
  //                 .where((currency) => !localCurrencyCodes.contains(currency['codigo']))
  //                 .toList();

  //             for (var moneda in newCurrencies) {
  //               Currency currency = Currency.fromJson(moneda);
  //               await _database.dbInsert('monedas', currency.toMap());
  //             }

  //             page++;
  //           } else {
  //             hasMoreData = false;
  //           }
  //         } else {
  //           hasMoreData = false;
  //         }
  //       }

  //       await loadCurrenciesFromDatabase();
  //     } else {
  //       _currencies = await _database.dbGetAll('monedas');
  //     }
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> loadCurrenciesFromDatabase() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   final List<Map<String, dynamic>> localCurrencies = await _database.dbGetAll('monedas');
  //   _currencies = localCurrencies;

  //   _isLoading = false;
  //   notifyListeners();
  // }
}
