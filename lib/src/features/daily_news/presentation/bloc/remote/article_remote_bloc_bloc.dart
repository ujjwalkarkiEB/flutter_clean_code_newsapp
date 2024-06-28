import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_code_news_app/src/core/utils/resources/data_state.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/usecases/get_articles.dart';

part 'article_remote_bloc_event.dart';
part 'article_remote_bloc_state.dart';

class ArticleRemoteBloc
    extends Bloc<ArticleRemoteBlocEvent, ArticleRemoteBlocState> {
  ArticleRemoteBloc(this._getArticlesUseCase)
      : super(const RemoteArticlesFetching()) {
    on<GetArticlesEvent>(onGetArticles);
  }
  final GetArticleUsecase _getArticlesUseCase;

  void onGetArticles(
      GetArticlesEvent event, Emitter<ArticleRemoteBlocState> emit) async {
    final dataState = await _getArticlesUseCase();

    if (dataState is DataSucces && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesFetched(dataState.data!));
    }

    if (dataState is DataError) {
      emit(RemoteArticlesFetchingError(dataState.error!));
    }
  }
}
