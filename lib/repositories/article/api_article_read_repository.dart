import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/article_model.dart';
import 'package:syncman_new/repositories/article/article_read_repository.dart';

class ApiArticleReadRepository extends ArticleReadRepository {
  final ApiService _api;

  ApiArticleReadRepository(this._api);

  @override
  Future<List<Articulo>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/articulos', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((article) {
      article['id'] = article['_id'];
      return Articulo.fromMap(article);
    }).toList();
  }

  @override
  Future<Articulo?> getById(String id) async {
    final response = await _api.getRequestNew('/articulos/$id');
    final data = response?.data;

    if (data) {
      return Articulo.fromMap(data);
    }

    return null;
  }

  @override
  Future<Articulo?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/articulos/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Articulo.fromMap(data);
    }

    return null;
  }
} 