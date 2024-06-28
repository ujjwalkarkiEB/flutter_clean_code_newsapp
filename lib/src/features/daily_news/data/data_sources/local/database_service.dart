import 'dart:convert';

import 'package:flutter_clean_code_news_app/src/features/daily_news/data/data_sources/local/database_helper.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';

class DatabaseService {
  DatabaseService({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper;

  final DatabaseHelper _databaseHelper;

  Future<void> addArticle(ArticleModel article) async {
    try {
      final box = _databaseHelper.articleBox;
      final encodedArticle = jsonEncode(article.toJson());
      await box.put(article.publishedAt, encodedArticle);
    } catch (e) {
      print('Error saving article: $e');
    }
  }

  Future<void> deleteArticle(ArticleModel article) async {
    try {
      final box = _databaseHelper.articleBox;

      await box.delete(article.publishedAt);
    } catch (e) {
      print('Error removing article: $e');
    }
  }

  Future<List<ArticleModel>> getAllArticles() async {
    try {
      final box = _databaseHelper.articleBox;
      final List<String> encodedArticles = box.values.toList();
      return encodedArticles
          .map((article) => ArticleModel.fromJson(jsonDecode(article)))
          .toList();
    } catch (e) {
      print('Error getting all local saved article: $e');
      return [];
    }
  }
}
