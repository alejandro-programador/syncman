import 'package:syncman_new/models/category_model.dart';
import 'package:syncman_new/repositories/category/category_read_repository.dart';
import 'package:syncman_new/repositories/category/category_write_repository.dart';

class CategoryService {
  final CategoryReadRepository _categoryReadRepository;
  final CategoryWriteRepository _categoryWriteRepository;

  CategoryService(this._categoryReadRepository, this._categoryWriteRepository);

  Future<List<Category>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _categoryReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Category> getById(String id) async {
    final category = await _categoryReadRepository.getById(id);
    if (category == null) {
      throw Exception('Category not found');
    }

    return category;
  }

  Future<Category> getByCodigo(String codigo) async {
    final category = await _categoryReadRepository.getByCodigo(codigo);
    if (category == null) {
      throw Exception('Category not found');
    }

    return category;
  }

  Future<void> updateOrCreate(Category category) async {
    await _categoryWriteRepository.updateOrCreate(category);
  }
} 