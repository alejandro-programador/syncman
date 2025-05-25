import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/price_model.dart';
import 'package:syncman_new/repositories/price/price_read_repository.dart';

class ApiPriceReadRepository extends PriceReadRepository {
  final ApiService _api;

  ApiPriceReadRepository(this._api);

  @override
  Future<List<Price>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/articulo-precios', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((price) {
      price['id'] = price['_id'];
      return Price.fromJson(price);
    }).toList();
  }

  @override
  Future<Price?> getById(String id) async {
    final response = await _api.getRequestNew('/articulo-precios/$id');
    final data = response?.data;

    if (data) {
      return Price.fromJson(data);
    }

    return null;
  }

  @override
  Future<Price?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/articulo-precios/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Price.fromJson(data);
    }

    return null;
  }
} 