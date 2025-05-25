import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/collect_payment_method.dart';
import 'package:syncman_new/repositories/collect_payment_method/collect_payment_method_read_repository.dart';

class ApiCollectPaymentMethodReadRepository extends CollectPaymentMethodReadRepository {
  final ApiService _api;

  ApiCollectPaymentMethodReadRepository(this._api);

  @override
  Future<List<CollectPaymentMethod>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await _api.getRequestNew('/metodo-cobro', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((paymentMethod) {
      paymentMethod['id'] = paymentMethod['_id'];
      return CollectPaymentMethod.fromMap(paymentMethod);
    }).toList();
  }

  @override
  Future<CollectPaymentMethod?> getById(String id) async {
    final response = await _api.getRequestNew('/metodo-cobro/$id');
    final data = response?.data;

    if (data != null) {
      data['id'] = data['_id'];
      return CollectPaymentMethod.fromMap(data);
    }

    return null;
  }

  @override
  Future<CollectPaymentMethod?> getByDescripcion(String descripcion) async {
    final response = await _api.getRequestNew('/metodo-cobro/descripcion/$descripcion');
    final data = response?.data;

    if (data != null) {
      data['id'] = data['_id'];
      return CollectPaymentMethod.fromMap(data);
    }

    return null;
  }
} 