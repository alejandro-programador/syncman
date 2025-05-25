import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/payment_condition_model.dart';
import 'package:syncman_new/repositories/payment_condition/payment_condition_read_repository.dart';

class ApiPaymentConditionReadRepository extends PaymentConditionReadRepository {
  final ApiService _api;

  ApiPaymentConditionReadRepository(this._api);

  @override
  Future<List<PaymentCondition>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/condicion-pagos', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((condicionPago) {
      condicionPago['id'] = condicionPago['_id'];
      return PaymentCondition.fromJson(condicionPago);
    }).toList();
  }

  @override
  Future<PaymentCondition?> getById(String id) async {
    final response = await _api.getRequestNew('/condicion-pagos/$id');
    final data = response?.data;

    if (data) {
      return PaymentCondition.fromJson(data);
    }

    return null;
  }

  @override
  Future<PaymentCondition?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/condicion-pagos/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return PaymentCondition.fromJson(data);
    }

    return null;
  }
} 