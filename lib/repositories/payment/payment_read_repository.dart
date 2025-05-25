import 'package:syncman_new/models/payment_model.dart';

abstract class PaymentReadRepository {
  Future<List<Payment>> query({
    String? updatedAt,
    int? page,
  });
  Future<Payment?> getById(String id);
  Future<Payment?> getByCodigo(String codigo);
} 