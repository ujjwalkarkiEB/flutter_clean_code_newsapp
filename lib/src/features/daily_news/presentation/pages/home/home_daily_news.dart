import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_code_news_app/src/common/widgets/tiles/article_tile.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/bloc/remote/article_remote_bloc_bloc.dart';
import 'package:gap/gap.dart';

@RoutePage()
class HomeDailyNewsPage extends StatelessWidget {
  const HomeDailyNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: BlocBuilder<ArticleRemoteBloc, ArticleRemoteBlocState>(
        builder: (context, state) {
          if (state is RemoteArticlesFetching) {
            return Platform.isAndroid
                ? const Center(child: CircularProgressIndicator())
                : const Center(child: CupertinoActivityIndicator());
          }
          if (state is RemoteArticlesFetched) {
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Gap(10),
                itemCount: state.articles!.length,
                itemBuilder: (context, index) {
                  return ArticleTile(article: state.articles![index]);
                },
              ),
            );
          }
          return const Center(
            child: Text('Something went wrong!'),
          );
        },
      ),
    );
  }
}
