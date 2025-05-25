import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/article_model.dart';
import 'package:syncman_new/repositories/article/article_write_repository.dart';

class LocalArticleWriteRepository extends ArticleWriteRepository {
  final Future<Database> _database;

  LocalArticleWriteRepository(this._database);

  Future<Database> _getArticleDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Articulo article) async {
    final articleDB = await _getArticleDB();

    final existingArticle = await articleDB.query(
      'articles',
      where: '_id = ?',
      whereArgs: [article.id],
    );

    if (existingArticle.isNotEmpty) {
      await articleDB.update(
        'articles',
        article.toMap(),
        where: '_id = ?',
        whereArgs: [article.id],
      );

      return;
    }

    await articleDB.insert('articles', article.toMap());
  }
} 