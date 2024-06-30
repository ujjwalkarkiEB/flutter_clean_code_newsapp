import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_code_news_app/src/common/widgets/snackbars/success_snackbar.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/bloc/local/article_local_bloc_bloc.dart';

import 'widgets/saved_artciles.dart';

@RoutePage()
class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    super.initState();
    context.read<ArticleLocalBloc>().add(GetLocalArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleLocalBloc, ArticleLocalBlocState>(
      listener: (context, state) {
        if (state is ArticleUnSaved) {
          showSuccessSnackbar(context, 'Successfully deleted from your list!',
              showUndo: true);
        }
      },
      builder: (context, state) {
        if (state is ArticleLocalFetching) {
          return Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator()
                  : const CupertinoActivityIndicator());
        }

        if (state is ArticleLocalFetched) {
          final List<ArticleModel> articles = state.articles;
          return articles.isEmpty
              ? const Center(
                  child: Text('Empty!'),
                )
              : SavePageArticles(articles: articles);
        }

        if (state is ArticleLocalFetchError) {
          return Center(
            child: Text('Error: ${state.error}'),
          );
        }

        if (state is ArticleUnsaveError) {
          return Center(
            child: Text('Error: ${state.error}'),
          );
        }

        return const Center(
          child: Text('Something went wrong!'),
        );
      },
    );
  }
}
