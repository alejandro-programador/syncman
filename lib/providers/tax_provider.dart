import 'package:flutter/material.dart';
import 'package:syncman_new/services/sync/tax_service.dart';

class TaxProvider with ChangeNotifier {
  // final AppDatabase _database;
  final TaxService _taxService;
  List<dynamic> _taxes = [];
  bool _isLoading = false;

  List<dynamic> get taxes => _taxes;
  bool get isLoading => _isLoading;

  TaxProvider(this._taxService);

  // Obtener datos desde la base local
  Future<void> loadTaxes() async {
    _isLoading = true;
    notifyListeners();

    final taxList = await _taxService.query();
    _taxes = taxList;

    _isLoading = false;
    notifyListeners();
  }

  // divided function
  // Future<void> fetchTaxes({bool? loadDatabase = false}) async {
  //   if (loadDatabase == true) {
  //     await loadTaxesFromDatabase();
  //     return;
  //   }
  //   if (_isLoading) return;
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     List<Map<String, dynamic>> localTaxesData = await _database.dbGetAll('impuestos');
  //     List<Tax> localTaxes = localTaxesData.map((tax) => Tax.fromJson(tax)).toList();

  //     if (await NetworkUtils.hasInternetConnection()) {
  //       await fetchTaxesFromApi(localTaxes);
  //     } else {
  //       _taxes = localTaxes;
  //     }
  //   } catch (e) {
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // // divided function
  // Future<void> fetchTaxesFromApi(List<Tax> localTaxes) async {
  //   int page = PaginationConfig.defaultPage;
  //   bool hasMoreData = true;

  //   while (hasMoreData) {
  //     final response = await ApiService().getRequest('/impuesto-sobre-venta-renglones?page=$page&size=${PaginationConfig.defaultPageSize}');

  //     if (response != null && response.statusCode == 200) {
  //       final List<dynamic> data = response.data;

  //       if (data.isNotEmpty) {
  //         final localTaxIds = localTaxes.map((t) => t.id).toSet();
  //         final newTaxes = data.where((tax) => !localTaxIds.contains(tax['_id'])).toList();

  //         await insertNewTaxes(newTaxes);
  //         page++;
  //       } else {
  //         hasMoreData = false;
  //       }
  //     } else {
  //       hasMoreData = false;
  //     }
  //   }

  //   await loadTaxesFromDatabase();
  // }

  // // divided function
  // Future<void> insertNewTaxes(List<dynamic> newTaxes) async {
  //   for (var tax in newTaxes) {
  //     Tax taxModel = Tax.fromJson(tax);
  //     await _database.dbInsert('impuestos', taxModel.toMap());
  //   }
  // }

  // // divided function
  // Future<void> loadTaxesFromDatabase() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     List<Map<String, dynamic>> taxesData = await _database.dbGetAll('impuestos');
  //     _taxes = taxesData.map((tax) => Tax.fromJson(tax)).toList();
  //   } catch (e) {
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }
} 