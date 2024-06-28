part of 'article_remote_bloc_bloc.dart';

sealed class ArticleRemoteBlocState extends Equatable {
  const ArticleRemoteBlocState({this.articles, this.error});
  final List<ArticleModel>? articles;
  final DioException? error;

  @override
  List<Object> get props => [articles!, error!];
}

class RemoteArticlesFetching extends ArticleRemoteBlocState {
  const RemoteArticlesFetching();
}

class RemoteArticlesFetched extends ArticleRemoteBlocState {
  const RemoteArticlesFetched(List<ArticleModel> articles)
      : super(articles: articles);
}

final class RemoteArticlesFetchingError extends ArticleRemoteBlocState {
  const RemoteArticlesFetchingError(DioException err) : super(error: err);
}
