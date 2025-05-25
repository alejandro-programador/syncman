import 'package:syncman_new/models/article_model.dart';

abstract class ArticleReadRepository {
  Future<List<Articulo>> query({
    String? updatedAt,
    int? page,
  });
  Future<Articulo?> getById(String id);
  Future<Articulo?> getByCodigo(String codigo);
} 