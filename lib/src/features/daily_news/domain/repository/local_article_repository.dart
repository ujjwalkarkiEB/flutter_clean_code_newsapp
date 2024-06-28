import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:hive/hive.dart';

import '../../../../core/utils/resources/data_state.dart';

abstract class LocalArticleRepository {
  Future<DataState<List<ArticleModel>, HiveError>>
      getAllSavedArticlesFromLocal();
  Future<void> saveArticle(ArticleModel article);
  Future<void> unsaveArticle(ArticleModel article);
}
