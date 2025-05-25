import 'package:syncman_new/models/order_model.dart';
import 'package:syncman_new/repositories/order/order_read_repository.dart';
import 'package:syncman_new/repositories/order/order_write_repository.dart';

class OrderService {
  final OrderReadRepository _orderReadRepository;
  final OrderWriteRepository _orderWriteRepository;

  OrderService(this._orderReadRepository, this._orderWriteRepository);

  Future<List<Order>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _orderReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Order> getById(String id) async {
    final order = await _orderReadRepository.getById(id);
    if (order == null) {
      throw Exception('Order not found');
    }
    return order;
  }

  Future<Order> getByCodigo(String codigo) async {
    final order = await _orderReadRepository.getByCodigo(codigo);
    if (order == null) {
      throw Exception('Order not found');
    }
    return order;
  }

  Future<void> updateOrCreate(Order order) async {
    await _orderWriteRepository.updateOrCreate(order);
  }
}
