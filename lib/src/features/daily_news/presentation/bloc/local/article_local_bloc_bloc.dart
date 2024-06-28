import 'package:bloc/bloc.dart';
import 'package:flutter_clean_code_news_app/src/core/utils/resources/data_state.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/usecases/save_articles.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/usecases/unsave_article.dart';
import 'package:hive/hive.dart';

part 'article_local_bloc_event.dart';
part 'article_local_bloc_state.dart';

class ArticleLocalBloc
    extends Bloc<ArticleLocalBlocEvent, ArticleLocalBlocState> {
  ArticleLocalBloc(this._getSavedArticlesUsecase, this._saveArticleUsecase,
      this._unSaveArticleUsecase)
      : super(LocalArticleInitial()) {
    on<GetLocalArticlesEvent>(_onGetLocalArticles);
    on<SaveLocalArticleEvent>(_onSaveArticle);
    on<UnsaveArticleEvent>(_onUnSaveArticle);
  }
  final GetSavedArticlesUsecase _getSavedArticlesUsecase;
  final SaveArticleUsecase _saveArticleUsecase;
  final UnSaveArticleUsecase _unSaveArticleUsecase;

  List<ArticleModel> savedBlocs = [];
  int? taskToBeDeletedIndex;

  void _onGetLocalArticles(
      GetLocalArticlesEvent event, Emitter<ArticleLocalBlocState> emit) async {
    emit(ArticleLocalFetching());
    final dataState = await _getSavedArticlesUsecase();
    if (dataState is DataSucces) {
      savedBlocs = dataState.data!;
      emit(ArticleLocalFetched(articles: dataState.data!));
    } else if (dataState is DataError) {
      emit(ArticleLocalFetchError(
          error: 'Unable to fetch articles from database!'));
    }
  }

  void _onSaveArticle(
      SaveLocalArticleEvent event, Emitter<ArticleLocalBlocState> emit) async {
    emit(SavingArticle());
    try {
      await _saveArticleUsecase(params: event.article);
      savedBlocs.add(event.article);

      emit(ArticleSaved());
      emit(ArticleLocalFetched(articles: savedBlocs.reversed.toList()));
    } on HiveError catch (e) {
      emit(ArticleSvingError(error: e));
    }
  }

  void _onUnSaveArticle(
      UnsaveArticleEvent event, Emitter<ArticleLocalBlocState> emit) async {
    emit(UnSavingArticle());
    try {
      taskToBeDeletedIndex = savedBlocs.indexOf(event.article);
      if (!event.isUndo) {
        await _unSaveArticleUsecase(params: event.article);
        savedBlocs.remove(event.article);
        emit(ArticleUnSaved());
        emit(ArticleLocalFetched(articles: savedBlocs));
      }
      await _saveArticleUsecase(params: event.article);
      savedBlocs.insert(taskToBeDeletedIndex!, event.article);
      emit(ArticleSaved());

      emit(ArticleLocalFetched(articles: savedBlocs));
    } catch (e) {
      emit(ArticleUnsaveError(error: 'Failed to unsave the article !'));
    }
  }

  @override
  void onTransition(
      Transition<ArticleLocalBlocEvent, ArticleLocalBlocState> transition) {
    super.onTransition(transition);
    print('---------------');
    print('trans : $transition');
  }
}
