import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/order_model.dart';
import 'package:syncman_new/repositories/order/order_read_repository.dart';

class ApiOrderReadRepository extends OrderReadRepository {
  final ApiService _api;

  ApiOrderReadRepository(this._api);

  @override
  Future<List<Order>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/pedido-ventas', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((client) {
      client['id'] = client['_id'];
      return Order.fromMap(client);
    }).toList();
  }

  @override
  Future<Order?> getById(String id) async {
    final response = await _api.getRequestNew('/pedido-ventas/$id');
    final data = response?.data;

    if (data) {
      return Order.fromMap(data);
    }

    return null;
  }

  @override
  Future<Order?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/pedido-ventas/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Order.fromMap(data);
    }

    return null;
  }
}
