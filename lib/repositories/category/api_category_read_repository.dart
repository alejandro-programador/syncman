import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/category_model.dart';
import 'package:syncman_new/repositories/category/category_read_repository.dart';

class ApiCategoryReadRepository extends CategoryReadRepository {
  final ApiService _api;

  ApiCategoryReadRepository(this._api);

  @override
  Future<List<Category>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/categorias', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((category) {
      category['id'] = category['_id'];
      return Category.fromJson(category);
    }).toList();
  }

  @override
  Future<Category?> getById(String id) async {
    final response = await _api.getRequestNew('/categorias/$id');
    final data = response?.data;

    if (data) {
      return Category.fromJson(data);
    }

    return null;
  }

  @override
  Future<Category?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/categorias/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Category.fromJson(data);
    }

    return null;
  }
} 