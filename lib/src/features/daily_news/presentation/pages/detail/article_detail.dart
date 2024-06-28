import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_code_news_app/src/common/widgets/snackbars/success_snackbar.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/bloc/local/article_local_bloc_bloc.dart';

@RoutePage()
class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage(
      {Key? key, required this.article, this.isRemote = false})
      : super(key: key);

  final ArticleModel article;
  final bool isRemote;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArticleLocalBloc, ArticleLocalBlocState>(
        listenWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        listener: (context, state) {
          if (state is ArticleSaved) {
            showSuccessSnackbar(context, 'Saved Successfully !');
          }

          if (state is ArticleUnSaved) {
            showSuccessSnackbar(context, 'Article is removed successfully !');
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(article.title),
              actions: [
                BlocBuilder<ArticleLocalBloc, ArticleLocalBlocState>(
                  builder: (context, state) {
                    final isSaved = context
                        .read<ArticleLocalBloc>()
                        .savedBlocs
                        .contains(article);
                    return IconButton(
                        onPressed: () {
                          if (!isSaved) {
                            context
                                .read<ArticleLocalBloc>()
                                .add(SaveLocalArticleEvent(article: article));
                            return;
                          }
                          context
                              .read<ArticleLocalBloc>()
                              .add(UnsaveArticleEvent(article: article));
                        },
                        icon: isSaved
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.purple,
                              )
                            : const Icon(Icons.favorite_outline));
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: isRemote
                          ? 'remote:${article.publishedAt}'
                          : 'local:${article.publishedAt}',
                      child: article.urlToImage == null
                          ? Image.asset(
                              'assets/images/loading_failed.png',
                              fit: BoxFit.cover,
                              height: 300,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                article.urlToImage!,
                                fit: BoxFit.cover,
                                height: 300,
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            article.title,
                          ),
                          const SizedBox(height: 8),
                          if (article.author != null)
                            Text(
                              'Author: ${article.author}',
                            ),
                          const SizedBox(height: 8),
                          Text(
                            'Published At: ${article.publishedAt}',
                          ),
                          const SizedBox(height: 16),
                          Text(
                            article.content ?? '',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
