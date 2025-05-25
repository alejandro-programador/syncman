import 'package:syncman_new/models/collect_payment_method.dart';

abstract class CollectPaymentMethodReadRepository {
  Future<List<CollectPaymentMethod>> query({
    String? updatedAt,
    int? page,
  });
  Future<CollectPaymentMethod?> getById(String id);
  Future<CollectPaymentMethod?> getByDescripcion(String descripcion);
} 