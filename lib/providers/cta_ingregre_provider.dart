import 'package:flutter/material.dart';
import 'package:syncman_new/services/sync/ctaingeg_service.dart';

class CtaIngrEgrProvider with ChangeNotifier {
  // final AppDatabase _database;
  final CtaIngrEgrService _ctaIngrEgrService;
  List<dynamic> _ctaingregrs = [];
  bool _isLoading = false;

  List<dynamic> get ctaingregrs => _ctaingregrs;
  bool get isLoading => _isLoading;

  CtaIngrEgrProvider(this._ctaIngrEgrService);

   // Obtener datos desde la base local
  Future<void> loadCtaIngrEgrs() async {
    _isLoading = true;
    notifyListeners();

    final ctaingregrsList = await _ctaIngrEgrService.query();
    _ctaingregrs = ctaingregrsList;

    _isLoading = false;
    notifyListeners();
  }

  // Future<void> fetchCtaIngrEgrs({bool? loadDatabase = false}) async {
  //   if (loadDatabase == true) {
  //     await loadCtaIngrEgrsFromDatabase();
  //     return;
  //   }
  //   if (_isLoading) return; // Prevent multiple requests
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     List<Map<String, dynamic>> localCtaIngrEgrs = await _database.dbGetAll('cta_ingr_egr');

  //     if (await NetworkUtils.hasInternetConnection()) {
  //       int page = PaginationConfig.defaultPage;
  //       bool hasMoreData = true;

  //       while (hasMoreData) {
  //         final response = await ApiService()
  //             .getRequest('/cta-ingr-egr?page=$page&size=${PaginationConfig.defaultPageSize}');

  //         if (response != null && response.statusCode == 200) {
  //           final List<dynamic> data = response.data;

  //           if (data.isNotEmpty) {
  //             final localCtaIngrEgrCodes = localCtaIngrEgrs.map((c) => c['codigo']).toSet();

  //             final newCtaIngrEgrs = data
  //                 .where((ctaingregr) => !localCtaIngrEgrCodes.contains(ctaingregr['codigo']))
  //                 .toList();

  //             for (var dataCta in newCtaIngrEgrs) {
  //               CtaIngrEgr dataCtaSelected = CtaIngrEgr.fromJson(dataCta);
  //               await _database.dbInsert('cta_ingr_egr', dataCtaSelected.toMap());
  //             }

  //             page++;
  //           } else {
  //             hasMoreData = false;
  //           }
  //         } else {
  //           hasMoreData = false;
  //         }
  //       }

  //       await loadCtaIngrEgrsFromDatabase();
  //     } else {
  //       _ctaingregrs = await _database.dbGetAll('cta_ingr_egr');
  //     }
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> loadCtaIngrEgrsFromDatabase() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   final List<Map<String, dynamic>> localCtaIngrEgrs = await _database.dbGetAll('cta_ingr_egr');
  //   _ctaingregrs = localCtaIngrEgrs;

  //   _isLoading = false;
  //   notifyListeners();
  // }
}
