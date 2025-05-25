import 'package:flutter/material.dart';
import 'package:syncman_new/services/sync/transport_service.dart';

class TransportProvider with ChangeNotifier {
  final TransportService _transportService;
  // final AppDatabase _database;
  List<dynamic> _transports = [];
  bool _isLoading = false;

  List<dynamic> get transports => _transports;
  bool get isLoading => _isLoading;

  TransportProvider(this._transportService);

  // Obtener datos desde la base local
  Future<void> loadTransports() async {
    _isLoading = true;
    notifyListeners();

    final transportList = await _transportService.query();
    _transports = transportList;

    _isLoading = false;
    notifyListeners();
  }

  // Future<void> fetchTransports({bool? loadDatabase = false}) async {
  //   if (loadDatabase == true) {
  //     await loadTransportsFromDatabase();
  //     return;
  //   }
  //   if (_isLoading) return; // Prevent multiple requests
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     List<Map<String, dynamic>> localTransports = await _database.dbGetAll('transportes');

  //     if (await NetworkUtils.hasInternetConnection()) {
  //       int page = PaginationConfig.defaultPage;
  //       bool hasMoreData = true;

  //       while (hasMoreData) {
  //         final response = await ApiService()
  //             .getRequest('/transportes?page=$page&size=${PaginationConfig.defaultPageSize}');

  //         if (response != null && response.statusCode == 200) {
  //           final List<dynamic> data = response.data;

  //           if (data.isNotEmpty) {
  //             final localTransportCodes = localTransports.map((t) => t['codigo']).toSet();

  //             final newTransports = data
  //                 .where((transport) => !localTransportCodes.contains(transport['codigo']))
  //                 .toList();

  //             for (var transporte in newTransports) {
  //               Transport transportSelected = Transport.fromJson(transporte);
  //               await _database.dbInsert('transportes', transportSelected.toMap());
  //             }

  //             page++;
  //           } else {
  //             hasMoreData = false;
  //           }
  //         } else {
  //           hasMoreData = false;
  //         }
  //       }

  //       await loadTransportsFromDatabase();
  //     } else {
  //       _transports = await _database.dbGetAll('transportes');
  //     }
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> loadTransportsFromDatabase() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   final List<Map<String, dynamic>> localTransports = await _database.dbGetAll('transportes');
  //   _transports = localTransports;

  //   _isLoading = false;
  //   notifyListeners();
  // }
}
