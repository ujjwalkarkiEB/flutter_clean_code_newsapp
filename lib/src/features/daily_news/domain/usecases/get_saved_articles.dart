import 'package:flutter_clean_code_news_app/src/core/utils/resources/data_state.dart';
import 'package:flutter_clean_code_news_app/src/core/utils/usecase/usecase.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/repository/local_article_repository.dart';
import 'package:hive/hive.dart';

class GetSavedArticlesUsecase implements Usecase {
  GetSavedArticlesUsecase(
      {required LocalArticleRepository localArticleRepository})
      : _localArticleRepository = localArticleRepository;

  final LocalArticleRepository _localArticleRepository;

  @override
  Future<DataState<List<ArticleModel>, HiveError>> call({params}) {
    return _localArticleRepository.getAllSavedArticlesFromLocal();
  }
}
