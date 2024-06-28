part of 'article_remote_bloc_bloc.dart';

sealed class ArticleRemoteBlocEvent {
  const ArticleRemoteBlocEvent();
}

class GetArticlesEvent extends ArticleRemoteBlocEvent {}
