import 'package:flutter/material.dart';
import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/utils/network_utils.dart';
import 'package:syncman_new/config/pagination_config.dart';
import 'package:syncman_new/services/sync/bill_service.dart';

class BillProvider extends ChangeNotifier {
  final BillService _billService;
  List<Bill> _bills = [];
  Map<String, dynamic> _billDetail = {};
  bool _isLoading = false;

  List<Bill> get bills => _bills;
  bool get isLoading => _isLoading;
  Map<String, dynamic> get billDetail => _billDetail;

  BillProvider(this._billService);

  Future<void> fetchBillData(String billCode) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await ApiService().getRequest('/factura-ventas/codigo/$billCode');
      if (response != null && response.statusCode == 200) {
        _billDetail = response.data;
        notifyListeners();
      } else {
        throw Exception(
            'Error al obtener perfil de factura. status: $response');
      }
    } catch (e) {
      throw Exception('Error al obtener perfil de factura: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Obtener datos desde la base local
  Future<void> loadBills() async {
    _isLoading = true;
    notifyListeners();

    final billList = await _billService.query();
    _bills = billList;

    _isLoading = false;
    notifyListeners();
  }

  // Future<void> fetchBills({bool? loadDatabase = false}) async {
  //   if (loadDatabase == true) {
  //     await loadBillsFromDatabase();
  //     return;
  //   }
  //   if (_isLoading) return; // Prevent multiple requests
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     if (await NetworkUtils.hasInternetConnection()) {
  //       int page = PaginationConfig.defaultPage;
  //       bool hasMoreData = true;

  //       while (hasMoreData) {
  //         final bills = await _billService.query(page: page);
  //         if (bills.isNotEmpty) {
  //           for (var bill in bills) {
  //             await _billService.updateOrCreate(bill);
  //           }
  //           page++;
  //         } else {
  //           hasMoreData = false;
  //         }
  //       }

  //       await loadBillsFromDatabase();
  //     } else {
  //       await loadBillsFromDatabase();
  //     }
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> loadBillsFromDatabase() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     _bills = await _billService.query();
  //   } catch (e) {
  //     _bills = [];
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<Map<String, dynamic>> fetchArticle(String articleCode) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getRequest('/articulos/$articleCode');
      if (response != null && response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Error al obtener el artículo. status: $response');
      }
    } catch (e) {
      throw Exception('Error al obtener el artículo: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadBillsByClientId(String clientId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Clear previous bills to free memory
      _bills = [];
      notifyListeners();

      // Get bills from service
      _bills = await _billService.getByClientId(clientId);
    } catch (e) {
      _bills = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
