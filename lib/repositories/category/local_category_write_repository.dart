import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/category_model.dart';
import 'package:syncman_new/repositories/category/category_write_repository.dart';

class LocalCategoryWriteRepository extends CategoryWriteRepository {
  final Future<Database> _database;

  LocalCategoryWriteRepository(this._database);

  Future<Database> _getCategoryDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Category category) async {
    final categoryDB = await _getCategoryDB();

    final existingCategory = await categoryDB.query(
      'categories',
      where: '_id = ?',
      whereArgs: [category.id],
    );

    if (existingCategory.isNotEmpty) {
      await categoryDB.update(
        'categories',
        category.toMap(),
        where: '_id = ?',
        whereArgs: [category.id],
      );

      return;
    }

    await categoryDB.insert('categories', category.toMap());
  }
} 