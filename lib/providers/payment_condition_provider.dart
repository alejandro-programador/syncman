import 'package:flutter/material.dart';
import 'package:syncman_new/services/sync/payment_condition_service.dart';

class PaymentConditionProvider with ChangeNotifier {
  // final AppDatabase _database;
  final PaymentConditionService _paymentConditionService;
  List<dynamic> _paymentconditions = [];
  bool _isLoading = false;

  List<dynamic> get paymentconditions => _paymentconditions;
  bool get isLoading => _isLoading;

  PaymentConditionProvider(this._paymentConditionService);

  // Obtener datos desde la base local
  Future<void> loadPaymentConditions() async {
    _isLoading = true;
    notifyListeners();

    final paymentconditionList = await _paymentConditionService.query();
    _paymentconditions = paymentconditionList;

    _isLoading = false;
    notifyListeners();
  }

  // Future<void> fetchPaymentConditions({bool? loadDatabase = false}) async {
  //   if (loadDatabase == true) {
  //     await loadPaymentConditionsFromDatabase();
  //     return;
  //   }
  //   if (_isLoading) return; // Prevent multiple requests
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     List<Map<String, dynamic>> localPaymentConditions =
  //         await _database.dbGetAll('condicion_pagos');

  //     if (await NetworkUtils.hasInternetConnection()) {
  //       int page = PaginationConfig.defaultPage;
  //       bool hasMoreData = true;

  //       while (hasMoreData) {
  //         final response = await ApiService()
  //             .getRequest('/condicion-pagos?page=$page&size=${PaginationConfig.defaultPageSize}');

  //         if (response != null && response.statusCode == 200) {
  //           final List<dynamic> data = response.data;

  //           if (data.isNotEmpty) {
  //             final localPaymentConditionCodes =
  //                 localPaymentConditions.map((c) => c['codigo']).toSet();

  //             final newPaymentConditions = data
  //                 .where((paymentcondition) =>
  //                     !localPaymentConditionCodes.contains(paymentcondition['codigo']))
  //                 .toList();

  //             for (var condicion in newPaymentConditions) {
  //               PaymentCondition conditionSelected = PaymentCondition.fromJson(condicion);
  //               await _database.dbInsert('condicion_pagos', conditionSelected.toMap());
  //             }

  //             page++;
  //           } else {
  //             hasMoreData = false;
  //           }
  //         } else {
  //           hasMoreData = false;
  //         }
  //       }

  //       await loadPaymentConditionsFromDatabase();
  //     } else {
  //       _paymentconditions = await _database.dbGetAll('condicion_pagos');
  //     }
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> loadPaymentConditionsFromDatabase() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   final List<Map<String, dynamic>> localPaymentConditions =
  //       await _database.dbGetAll('condicion_pagos');

  //   _paymentconditions = localPaymentConditions;

  //   _isLoading = false;
  //   notifyListeners();
  // }
}
