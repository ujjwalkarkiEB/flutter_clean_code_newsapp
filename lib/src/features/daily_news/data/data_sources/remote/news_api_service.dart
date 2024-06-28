import 'package:dio/dio.dart';
import 'package:flutter_clean_code_news_app/src/core/utils/constants/string_constants.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query('apiKey') String? apiKey,
    @Query('country') String? country,
    @Query('category') String? category,
  });
}
