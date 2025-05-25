import 'package:syncman_new/models/payment_condition_model.dart';

abstract class PaymentConditionReadRepository {
  Future<List<PaymentCondition>> query({
    String? updatedAt,
    int? page,
  });
  Future<PaymentCondition?> getById(String id);
  Future<PaymentCondition?> getByCodigo(String codigo);
} 