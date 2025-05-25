import 'package:syncman_new/models/article_model.dart';

abstract class ArticleWriteRepository {
  Future<void> updateOrCreate(Articulo article);
} 