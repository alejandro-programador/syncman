import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/seller_model.dart';
import 'package:syncman_new/repositories/seller/seller_read_repository.dart';

class ApiSellerReadRepository extends SellerReadRepository {
  final ApiService _api;

  ApiSellerReadRepository(this._api);

  @override
  Future<List<Seller>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/vendedores', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((client) {
      client['id'] = client['_id'];
      return Seller.fromMap(client);
    }).toList();
  }

  @override
  Future<Seller?> getById(String id) async {
    final response = await _api.getRequestNew('/vendedores/$id');
    final data = response?.data;

    if (data) {
      return Seller.fromMap(data);
    }

    return null;
  }

  @override
  Future<Seller?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/vendedores/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Seller.fromMap(data);
    }

    return null;
  }
}
