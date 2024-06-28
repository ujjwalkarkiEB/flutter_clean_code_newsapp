import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_clean_code_news_app/src/core/utils/constants/string_constants.dart';
import 'package:flutter_clean_code_news_app/src/core/utils/resources/data_state.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  ArticleRepositoryImpl({required NewsApiService newsApiService})
      : _newsApiService = newsApiService;

  final NewsApiService _newsApiService;
  @override
  Future<DataState<List<ArticleModel>, DioException>> getAllArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
          apiKey: apiKey, country: 'us', category: 'general');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSucces(httpResponse.data);
      } else {
        return DataError(DioException(
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response.statusMessage,
            response: httpResponse.response));
      }
    } on DioException catch (e) {
      return DataError(e);
    }
  }
}
