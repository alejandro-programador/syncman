import 'package:flutter/material.dart';
import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/services/sync/seller_service.dart';

class SellersProvider with ChangeNotifier {
  final SellerService _sellerService;
  // final AppDatabase _database;
  List<dynamic> _sellers = [];
  Map<String, dynamic> _sellerProfile = {};
  bool _isLoading = false;

  List<dynamic> get sellers => _sellers;
  bool get isLoading => _isLoading;
  Map<String, dynamic> get sellerProfile => _sellerProfile;

  SellersProvider(this._sellerService);

  Future<void> fetchSellerData(String sellerDNI) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await ApiService().getRequest('/vendedores/cedula/$sellerDNI');
      if (response != null && response.statusCode == 200) {
        _sellerProfile = response.data;
        notifyListeners();
      } else {
        throw Exception(
            'Error al obtener perfil de vendedor. status: $response');
      }
    } catch (e) {
      throw Exception('Error al obtener perfil de vendedor: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Obtener datos desde la base local
  Future<void> loadSellers() async {
    _isLoading = true;
    notifyListeners();

    final sellerList = await _sellerService.query();
    _sellers = sellerList;

    _isLoading = false;
    notifyListeners();
  }

  // Future<void> fetchSellers({int page = 1, int size = 10}) async {
  //   if (_isLoading) return; // Prevent multiple requests
  //   _isLoading = true;
  //   notifyListeners();

  //   if (await NetworkUtils.hasInternetConnection()) {
  //     try {
  //       final response = await ApiService().getRequest('/vendedores?page=$page&size=$size');

  //       if (response != null && response.statusCode == 200) {
  //         final data = response.data;

  //         // If the response is empty, stop fetching
  //         if (data.isEmpty) {
  //           _isLoading = false;
  //           notifyListeners();
  //           return;
  //         }

  //         final localSellers = await _database.dbGetAll('sellers');
  //         final localSellerCodes = localSellers.map((s) => s['codigo']).toSet();

  //         final notRegisteredSellers =
  //             data.where((seller) => !localSellerCodes.contains(seller['codigo'])).toList();

  //         for (var seller in notRegisteredSellers) {
  //           await _database.dbInsert('sellers', {
  //             // 'id': seller['id'] ?? "",
  //             'codigo': seller['codigo'] ?? "",
  //             'descripcion': seller['descripcion'] ?? "",
  //             'tipo': seller['tipo'] ?? "",
  //             'zona': seller['zona'] ?? "",
  //             'cedula': seller['cedula'] ?? "",
  //             'direc1': seller['direc1'] ?? "",
  //             'telefonos': seller['telefonos'] ?? "",
  //             'fechaReg': seller['fechaReg'] ?? "",
  //             'inactivo': seller['inactivo'] ?? 0,
  //             'comision': seller['comision'] ?? 0.0,
  //             'comentario': seller['comentario'] ?? "",
  //             'funCob': seller['funCob'] ?? 0,
  //             'funVen': seller['funVen'] ?? 0,
  //             'comisionv': seller['comisionv'] ?? 0.0,
  //             'login': seller['login'] ?? "",
  //             'password': seller['password'] ?? "",
  //             'email': seller['email'] ?? "",
  //             'saldo_deudor': seller['saldo_deudor'] ?? 0,
  //             'saldo_deudor_total': seller['saldo_deudor_total'] ?? 0,
  //             'saldoCXC': seller['saldoCXC'] ?? 0,
  //           });
  //         }

  //         // notifyListeners();

  //         loadSellersFromDatabase();
  //       } else {
  //         throw Exception('Error al obtener vendedores. status: $response');
  //       }
  //     } catch (e) {
  //       throw Exception('Error al obtener vendedores: $e');
  //     }
  //   } else {
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }

  // Future<void> loadSellersFromDatabase() async {
  //   try {
  //     final sellersList = await _database.dbGetAll('sellers');
  //     _sellers = sellersList
  //         .map((seller) => {
  //               'id': seller['id'],
  //               'codigo': seller['codigo'],
  //               'descripcion': seller['descripcion'],
  //               'tipo': seller['tipo'],
  //               'zona': seller['zona'],
  //               'cedula': seller['cedula'],
  //               'direc1': seller['direc1'],
  //               'telefonos': seller['telefonos'],
  //               'fechaReg': seller['fechaReg'],
  //               'inactivo': seller['inactivo'],
  //               'comision': seller['comision'],
  //               'comentario': seller['comentario'],
  //               'funCob': seller['funCob'],
  //               'funVen': seller['funVen'],
  //               'comisionv': seller['comisionv'],
  //               'login': seller['login'],
  //               'password': seller['password'],
  //               'email': seller['email'],
  //               'saldo_deudor': seller['saldo_deudor'] ?? 0,
  //               'saldo_deudor_total': seller['saldo_deudor_total'] ?? 0,
  //               'saldoCXC': seller['saldoCXC'] ?? 0,
  //             })
  //         .toList();
  //     notifyListeners();
  //   } catch (e) {
  //     throw Exception('Error al cargar vendedores desde la base de datos: $e');
  //   }
  // }

  

  // Future<void> clearTable() async {
  //   await _database.dbClearTable('sellers');
  //   // await db.delete('sellers');
  // }
}
