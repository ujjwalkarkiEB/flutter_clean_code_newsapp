import 'package:flutter_clean_code_news_app/src/core/utils/usecase/usecase.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/repository/local_article_repository.dart';

class SaveArticleUsecase implements Usecase<void, ArticleModel> {
  SaveArticleUsecase({required LocalArticleRepository localArticleRepository})
      : _localArticleRepository = localArticleRepository;

  final LocalArticleRepository _localArticleRepository;

  @override
  Future<void> call({ArticleModel? params}) {
    return _localArticleRepository.saveArticle(params!);
  }
}
