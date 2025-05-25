import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/article_model.dart';
import 'package:syncman_new/repositories/article/article_read_repository.dart';

class LocalArticleReadRepository extends ArticleReadRepository {
  final Future<Database> _database;

  LocalArticleReadRepository(this._database);

  Future<Database> _getArticleDB() async {
    return await _database;
  }

  @override
  Future<List<Articulo>> query({
    String? updatedAt,
    int? page,
  }) async {
    final articleDB = await _getArticleDB();

    final whereClauses = <String>[];
    final whereArgs = <String>[];

    if (updatedAt != null) {
      whereClauses.add('updatedAt >= ?');
      whereArgs.add(updatedAt);
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    final result = await articleDB.query(
      'articles',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    return result.map((map) => Articulo.fromMap(map)).toList();
  }

  @override
  Future<Articulo?> getById(String id) async {
    final articleDB = await _getArticleDB();

    final result = await articleDB.query(
      'articles',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Articulo.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<Articulo?> getByCodigo(String codigo) async {
    final articleDB = await _getArticleDB();

    final result = await articleDB.query(
      'articles',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return Articulo.fromMap(result.first);
    }

    return null;
  }
} 