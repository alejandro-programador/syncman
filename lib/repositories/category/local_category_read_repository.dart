import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/category_model.dart';
import 'package:syncman_new/repositories/category/category_read_repository.dart';

class LocalCategoryReadRepository extends CategoryReadRepository {
  final Future<Database> _database;

  LocalCategoryReadRepository(this._database);

  Future<Database> _getCategoryDB() async {
    return await _database;
  }

  @override
  Future<List<Category>> query({
    String? updatedAt,
    int? page,
  }) async {
    final categoryDB = await _getCategoryDB();

    final whereClauses = <String>[];
    final whereArgs = <String>[];

    if (updatedAt != null) {
      whereClauses.add('updatedAt >= ?');
      whereArgs.add(updatedAt);
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    final result = await categoryDB.query(
      'categories',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    return result.map((map) => Category.fromJson(map)).toList();
  }

  @override
  Future<Category?> getById(String id) async {
    final categoryDB = await _getCategoryDB();

    final result = await categoryDB.query(
      'categories',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Category.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<Category?> getByCodigo(String codigo) async {
    final categoryDB = await _getCategoryDB();

    final result = await categoryDB.query(
      'categories',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return Category.fromJson(result.first);
    }

    return null;
  }
} 