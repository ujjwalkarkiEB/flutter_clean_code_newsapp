import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../common/widgets/tiles/article_tile.dart';
import '../../../../domain/model/article.dart';

class SavePageArticles extends StatelessWidget {
  const SavePageArticles({
    super.key,
    required this.articles,
  });

  final List<ArticleModel> articles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView.separated(
        separatorBuilder: (_, __) => const Gap(10),
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return ArticleTile(
            article: articles[index],
            showDeleteButton: true,
          );
        },
      ),
    );
  }
}
