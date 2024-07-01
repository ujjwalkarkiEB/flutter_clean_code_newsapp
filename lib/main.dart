import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_code_news_app/src/core/config/route/app_route.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/data/data_sources/local/database_helper.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/injection_container.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/bloc/local/article_local_bloc_bloc.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/bloc/remote/article_remote_bloc_bloc.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/pages/widgets/connectivity_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializedDependencies();
  await sl<DatabaseHelper>().initializeLocalDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleRemoteBloc>(
            create: (_) => sl()..add(GetArticlesEvent())),
        BlocProvider<ArticleLocalBloc>(create: (_) => sl<ArticleLocalBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
