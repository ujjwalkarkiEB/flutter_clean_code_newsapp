import 'package:dio/dio.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';

import '../../../../core/utils/resources/data_state.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleModel>, DioException>> getAllArticles();
}
