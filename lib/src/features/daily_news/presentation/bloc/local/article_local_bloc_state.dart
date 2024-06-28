part of 'article_local_bloc_bloc.dart';

sealed class ArticleLocalBlocState {}

class LocalArticleInitial extends ArticleLocalBlocState {}

// action states
class SavingArticle extends ArticleLocalBlocState {}

class UnSavingArticle extends ArticleLocalBlocState {}

class ArticleSaved extends ArticleLocalBlocState {}

class ArticleUnSaved extends ArticleLocalBlocState {}

class ArticleSvingError extends ArticleLocalBlocState {
  ArticleSvingError({required this.error});

  final HiveError error;
}

class ArticleUnsaveError extends ArticleLocalBlocState {
  ArticleUnsaveError({required this.error});
  final String error;
}

// building states
class ArticleLocalFetching extends ArticleLocalBlocState {}

class ArticleLocalFetched extends ArticleLocalBlocState {
  ArticleLocalFetched({required this.articles});

  final List<ArticleModel> articles;
}

class ArticleLocalFetchError extends ArticleLocalBlocState {
  ArticleLocalFetchError({required this.error});
  final String error;
}
