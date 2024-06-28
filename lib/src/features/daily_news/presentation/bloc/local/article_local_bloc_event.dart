part of 'article_local_bloc_bloc.dart';

sealed class ArticleLocalBlocEvent {
  const ArticleLocalBlocEvent();
}

class GetLocalArticlesEvent extends ArticleLocalBlocEvent {}

class UnsaveArticleEvent extends ArticleLocalBlocEvent {
  UnsaveArticleEvent({required this.article, this.isUndo = false});

  final ArticleModel article;
  final bool isUndo;
}

class SaveLocalArticleEvent extends ArticleLocalBlocEvent {
  SaveLocalArticleEvent({required this.article});

  final ArticleModel article;
}
