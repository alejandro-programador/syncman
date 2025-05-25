import 'package:flutter/material.dart';
import 'package:syncman_new/database/app_database.dart';
import 'package:syncman_new/models/article_model.dart';
import 'package:syncman_new/repositories/article/local_article_read_repository.dart';

class TestArticlesScreen extends StatefulWidget {
  const TestArticlesScreen({Key? key}) : super(key: key);

  @override
  State<TestArticlesScreen> createState() => _TestArticlesScreenState();
}

class _TestArticlesScreenState extends State<TestArticlesScreen> {
  List<Articulo> articles = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadArticles();
  }

  Future<void> loadArticles() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final database = AppDatabase.instance;
      final repository = LocalArticleReadRepository(database.database);
      
      print('=== Loading Articles ===');
      final loadedArticles = await repository.query();
      print('Number of articles loaded: ${loadedArticles.length}');
      
      if (loadedArticles.isNotEmpty) {
        print('First article details:');
        print('ID: ${loadedArticles.first.id}');
        print('Código: ${loadedArticles.first.codigo}');
        print('Descripción: ${loadedArticles.first.descripcion}');
      }

      setState(() {
        articles = loadedArticles;
        isLoading = false;
      });
    } catch (e, stackTrace) {
      print('Error loading articles: $e');
      print('Stack trace: $stackTrace');
      setState(() {
        errorMessage = 'Error loading articles: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Articles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadArticles,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : articles.isEmpty
                  ? const Center(child: Text('No articles found'))
                  : ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(article.descripcion),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Código: ${article.codigo}'),
                                Text('ID: ${article.id}'),
                                Text('Descripción: ${article.descripcion}'),
                                Text('Tipo: ${article.tipo}'),
                                Text('Modelo: ${article.modelo}'),
                                Text('Referencia: ${article.referencia}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
} 