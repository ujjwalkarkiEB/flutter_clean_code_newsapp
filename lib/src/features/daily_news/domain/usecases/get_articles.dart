import 'package:dio/dio.dart';
import 'package:flutter_clean_code_news_app/src/core/utils/resources/data_state.dart';
import 'package:flutter_clean_code_news_app/src/core/utils/usecase/usecase.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/repository/article_repository.dart';

class GetArticleUsecase implements Usecase {
  GetArticleUsecase({required ArticleRepository articleRepository})
      : _articleRepository = articleRepository;

  final ArticleRepository _articleRepository;
  @override
  Future<DataState<List<ArticleModel>, DioException>> call({params}) {
    return _articleRepository.getAllArticles();
  }
}
