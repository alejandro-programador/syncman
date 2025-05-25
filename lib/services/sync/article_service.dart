import 'package:syncman_new/models/article_model.dart';
import 'package:syncman_new/repositories/article/article_read_repository.dart';
import 'package:syncman_new/repositories/article/article_write_repository.dart';

class ArticleService {
  final ArticleReadRepository _articleReadRepository;
  final ArticleWriteRepository _articleWriteRepository;

  ArticleService(this._articleReadRepository, this._articleWriteRepository);

  Future<List<Articulo>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _articleReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Articulo> getById(String id) async {
    final article = await _articleReadRepository.getById(id);
    if (article == null) {
      throw Exception('Article not found');
    }

    return article;
  }

  Future<Articulo> getByCodigo(String codigo) async {
    final article = await _articleReadRepository.getByCodigo(codigo);
    if (article == null) {
      throw Exception('Article not found');
    }

    return article;
  }

  Future<void> updateOrCreate(Articulo article) async {
    await _articleWriteRepository.updateOrCreate(article);
  }
} 