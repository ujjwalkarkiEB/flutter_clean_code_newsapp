import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'article_source.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    required Source source,
    required String? author,
    required String title,
    required String? description,
    required String url,
    required String? urlToImage,
    required String publishedAt,
    required String? content,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}
