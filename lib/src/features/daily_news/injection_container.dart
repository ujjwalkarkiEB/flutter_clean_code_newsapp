import 'package:dio/dio.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/data/data_sources/local/database_helper.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/data/data_sources/local/database_service.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/data/repository/local_article_repository_impl.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/repository/article_repository.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/usecases/get_articles.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/usecases/save_articles.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/usecases/unsave_article.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/bloc/local/article_local_bloc_bloc.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/bloc/remote/article_remote_bloc_bloc.dart';
import 'package:get_it/get_it.dart';

import 'domain/repository/local_article_repository.dart';

final sl = GetIt.instance;

Future<void> initializedDependencies() async {
  // dio
  sl.registerSingleton<Dio>(Dio());
  // network dependency
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));
  // database depedency

  // local database
  sl.registerSingleton<DatabaseHelper>(DatabaseHelper());
  sl.registerSingleton<DatabaseService>(DatabaseService(databaseHelper: sl()));

  // repository
  sl.registerSingleton<ArticleRepository>(
      ArticleRepositoryImpl(newsApiService: sl()));
  sl.registerSingleton<LocalArticleRepository>(
      LocalArticleRepositoryImpl(databaseService: sl()));
  // usecases
  sl.registerSingleton<GetArticleUsecase>(
      GetArticleUsecase(articleRepository: sl()));
  sl.registerSingleton<GetSavedArticlesUsecase>(
      GetSavedArticlesUsecase(localArticleRepository: sl()));
  sl.registerSingleton<SaveArticleUsecase>(
      SaveArticleUsecase(localArticleRepository: sl()));
  sl.registerSingleton<UnSaveArticleUsecase>(
      UnSaveArticleUsecase(localArticleRepository: sl()));

  //blocs
  sl.registerFactory<ArticleRemoteBloc>(() => ArticleRemoteBloc(sl()));
  sl.registerFactory<ArticleLocalBloc>(
      () => ArticleLocalBloc(sl(), sl(), sl()));
}
