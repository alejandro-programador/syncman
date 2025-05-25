import 'package:syncman_new/models/category_model.dart';

abstract class CategoryReadRepository {
  Future<List<Category>> query({
    String? updatedAt,
    int? page,
  });
  Future<Category?> getById(String id);
  Future<Category?> getByCodigo(String codigo);
} 