import 'package:flutter_clean_code_news_app/src/core/utils/resources/data_state.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/data/data_sources/local/database_service.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/repository/local_article_repository.dart';

import 'package:hive/hive.dart';

class LocalArticleRepositoryImpl extends LocalArticleRepository {
  LocalArticleRepositoryImpl({required this.databaseService});

  final DatabaseService databaseService;

  @override
  Future<DataState<List<ArticleModel>, HiveError>>
      getAllSavedArticlesFromLocal() async {
    try {
      final articles = await databaseService.getAllArticles();
      return DataSucces(articles);
    } on HiveError catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<void> saveArticle(ArticleModel article) async {
    try {
      await databaseService.addArticle(article);
    } on HiveError catch (e) {
      print('HiveError saving article: $e');
      throw e;
    }
  }

  @override
  Future<void> unsaveArticle(ArticleModel article) async {
    try {
      await databaseService.deleteArticle(article);
    } on HiveError catch (e) {
      print('HiveError deleting article: $e');
      throw e;
    }
  }
}
