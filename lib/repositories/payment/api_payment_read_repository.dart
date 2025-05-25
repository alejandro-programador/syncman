import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/payment_model.dart';
import 'package:syncman_new/repositories/payment/payment_read_repository.dart';

class ApiPaymentReadRepository extends PaymentReadRepository {
  final ApiService _api;

  ApiPaymentReadRepository(this._api);

  @override
  Future<List<Payment>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/solicitud-cobro', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((payment) {
      payment['id'] = payment['_id'];
      return Payment.fromMap(payment);
    }).toList();
  }

  @override
  Future<Payment?> getById(String id) async {
    final response = await _api.getRequestNew('/solicitud-cobro/$id');
    final data = response?.data;

    if (data) {
      return Payment.fromMap(data);
    }

    return null;
  }

  @override
  Future<Payment?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/solicitud-cobro/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Payment.fromMap(data);
    }

    return null;
  }
} 