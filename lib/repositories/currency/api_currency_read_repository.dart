import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/currency_model.dart';
import 'package:syncman_new/repositories/currency/currency_read_repository.dart';

class ApiCurrencyReadRepository extends CurrencyReadRepository {
  final ApiService _api;

  ApiCurrencyReadRepository(this._api);

  @override
  Future<List<Currency>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/monedas', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((moneda) {
      moneda['id'] = moneda['_id'];
      return Currency.fromJson(moneda);
    }).toList();
  }

  @override
  Future<Currency?> getById(String id) async {
    final response = await _api.getRequestNew('/monedas/$id');
    final data = response?.data;

    if (data) {
      return Currency.fromJson(data);
    }

    return null;
  }

  @override
  Future<Currency?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/monedas/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Currency.fromJson(data);
    }

    return null;
  }
} 