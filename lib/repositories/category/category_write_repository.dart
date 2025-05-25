import 'package:syncman_new/models/category_model.dart';

abstract class CategoryWriteRepository {
  Future<void> updateOrCreate(Category category);
} 