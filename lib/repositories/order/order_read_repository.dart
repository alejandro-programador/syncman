import 'package:syncman_new/models/order_model.dart';

abstract class OrderReadRepository {
  Future<List<Order>> query({
    String? updatedAt,
    int? page,
  });
  Future<Order?> getById(String id);
  Future<Order?> getByCodigo(String codigo);
}
