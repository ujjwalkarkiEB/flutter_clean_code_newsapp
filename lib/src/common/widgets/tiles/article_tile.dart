import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_code_news_app/src/core/config/route/app_route.gr.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/bloc/local/article_local_bloc_bloc.dart';
import 'package:gap/gap.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile(
      {Key? key, required this.article, this.showDeleteButton = false})
      : super(key: key);

  final ArticleModel article;
  final bool showDeleteButton;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        context.router.push(
            ArticleDetailRoute(article: article, isRemote: showDeleteButton));
      },
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Reduced border radius
          color: Colors.grey.withOpacity(0.1), // Lightened background color
          border: Border.all(color: Colors.grey.shade300), // Added border
        ),
        child: Stack(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image

              Hero(
                tag: !showDeleteButton
                    ? 'local:${article.publishedAt}'
                    : 'remote:${article.publishedAt}',
                child: article.urlToImage != null
                    ? CachedNetworkImage(
                        imageUrl: article.urlToImage!,
                        imageBuilder: (context, imageProvider) => Container(
                          height: width * 0.4,
                          width: width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(0.5),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          height: width * 0.4,
                          width: width * 0.4,
                          alignment: Alignment.center,
                          child: Platform.isAndroid
                              ? const CircularProgressIndicator()
                              : const CupertinoActivityIndicator(),
                        ),
                      )
                    : Image.asset(
                        'assets/images/loading_failed.png',
                        fit: BoxFit.cover,
                        height: width * 0.4,
                        width: width * 0.4,
                      ),
              ),
              const Gap(10),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 10),
                      child: Text(
                        article.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Butler',
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    // Description
                    Padding(
                      padding: const EdgeInsets.only(top: 4, right: 10),
                      child: Text(
                        article.description ?? '',
                        maxLines: 2,
                      ),
                    ),

                    // Date time
                    Row(
                      children: [
                        const Icon(Icons.timeline_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          article.publishedAt,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showDeleteButton)
            Positioned(
                left: 0,
                bottom: 0,
                child: IconButton(
                    onPressed: () {
                      context
                          .read<ArticleLocalBloc>()
                          .add(UnsaveArticleEvent(article: article));
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 35,
                      color: Colors.white,
                    ))),
        ]),
      ),
    );
  }
}
