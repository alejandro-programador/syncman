import 'package:flutter/material.dart';
import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/services/sync/order_service.dart';
import 'package:syncman_new/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  final OrderService _orderService;
  // final AppDatabase _database;
  bool _isLoading = false;
  List<Order> _orders = [];

  bool get isLoading => _isLoading;
  List<Order> get orders => _orders;
  OrderProvider(this._orderService);
  // OrderProvider(this._orderService) : _database = AppDatabase.instance;

  Future<bool> makeOrder(Map<String, dynamic> dataFromCart) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().postRequest(
        '/pedido-ventas',
        data: dataFromCart,
      );

      if (response != null) {
        if (response.statusCode == 200) {
          return true;
        } else if (response.statusCode == 422) {
          // Handle specific validation errors
          if (response.data is Map) {
            final errors = response.data as Map;
            errors.forEach((key, value) {});
          }
          return false;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Obtener datos desde la base local
  Future<void> loadOrders() async {
    _isLoading = true;
    notifyListeners();

    final orderList = await _orderService.query();
    _orders = orderList;

    _isLoading = false;
    notifyListeners();
  }

  // Future<void> fetchOrders(ClientsProvider clientProvider) async {
  //   if (_isLoading) return; // Prevent multiple requests
  //   _isLoading = true;
  //   notifyListeners();

  //   if (await NetworkUtils.hasInternetConnection()) {
  //     int page = PaginationConfig.defaultPage;
  //     bool hasMoreData = true;

  //     while (hasMoreData) {
  //       final response = await ApiService()
  //           .getRequest('/pedido-ventas?page=$page&size=${PaginationConfig.defaultPageSize}');

  //       if (response != null && response.statusCode == 200) {
  //         final List<dynamic> data = response.data;

  //         if (data.isNotEmpty) {
  //           // Avoid duplicate entries
  //           final localOrders = await _order.dbGetAll('orders');
  //           final localOrderCodes = localOrders.map((c) => c['codigo']).toSet();

  //           final notRegisteredOrders =
  //               data.where((order) => !localOrderCodes.contains(order['codigo'])).toList();

  //           // Insert only the new orders into the database
  //           for (var order in notRegisteredOrders) {
  //             Order orderSelected = Order.fromMap(order);
  //             await _database.dbInsert('orders', orderSelected.toMap());
  //           }

  //           page++;
  //         } else {
  //           hasMoreData = false;
  //         }
  //       } else {
  //         hasMoreData = false;
  //       }
  //     }

  //     // Load updated data from local database
  //     await loadOrdersFromDatabase(clientProvider);
  //   } else {
  //     await loadOrdersFromDatabase(clientProvider);
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }

  Future<String> fetchUserType(Order order) async {
    if (order.saldo > 0) return 'Moroso';
    if (order.saldo <= 0) return 'Al día';
    return '';
  }

  // Future<void> loadOrdersFromDatabase(ClientsProvider clientProvider) async {
  //   try {
  //     final orderList = await _database.dbGetAll('orders');

  //     for (var order in orderList) {
  //       Order orderSelected = Order.fromMap(order);
  //       await clientProvider.fetchClientByID(order['cliente']);
  //       Map<String, dynamic> clientData = clientProvider.clientProfile;

  //       fetchUserType(clientData).then((value) {
  //         clientData['userType'] = value;
  //       });

  //       _orders.add({
  //         ...orderSelected.toMap(),
  //         'clientdata': clientData, // * Test
  //       });
  //     }

  //     notifyListeners();
  //   } catch (e) {
  //     throw Exception('Error al cargar orderes desde la base de datos: $e');
  //   }
  // }
}
