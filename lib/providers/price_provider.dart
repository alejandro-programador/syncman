import 'package:flutter/material.dart';
import 'package:syncman_new/models/price_model.dart';
import 'package:syncman_new/services/sync/price_service.dart';
import 'package:syncman_new/utils/network_utils.dart';
import 'package:syncman_new/config/pagination_config.dart';

class PriceProvider extends ChangeNotifier {
  final PriceService _priceService;
  List<Price> _prices = [];
  List<Price> _priceList = [];
  final List<Price> _priceTypeList = [];
  bool _isLoading = false;

  List<Price> get prices => _prices;
  List<Price> get priceTypeList => _priceTypeList;
  List<Price> get priceList => _priceList;
  bool get isLoading => _isLoading;

  PriceProvider(this._priceService);

  Future<void> loadProductPricesFromDatabase() async {
    try {
      _priceList = await _priceService.query();
      notifyListeners();
    } catch (e) {
      _priceList = [];
    }
  }

  Future<void> fetchPrices({bool? loadDatabase = false}) async {
    if (loadDatabase == true) {
      await loadPricesFromDatabase();
      return;
    }
    if (_isLoading) return; // Prevent multiple requests
    _isLoading = true;
    notifyListeners();

    try {
      if (await NetworkUtils.hasInternetConnection()) {
        int page = PaginationConfig.defaultPage;
        bool hasMoreData = true;

        while (hasMoreData) {
          final prices = await _priceService.query(page: page);
          if (prices.isNotEmpty) {
            for (var price in prices) {
              await _priceService.updateOrCreate(price);
            }
            page++;
          } else {
            hasMoreData = false;
          }
        }

        await loadPricesFromDatabase();
      } else {
        await loadPricesFromDatabase();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPricesFromDatabase() async {
    _isLoading = true;
    notifyListeners();

    try {
      _prices = await _priceService.query();
    } catch (e) {
      _prices = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Price> getPriceById(String id) async {
    return await _priceService.getById(id);
  }

  Future<Price> getPriceByCodigo(String codigo) async {
    return await _priceService.getByCodigo(codigo);
  }
}
