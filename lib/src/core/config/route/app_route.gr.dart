// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter_clean_code_news_app/src/features/daily_news/domain/model/article.dart'
    as _i7;
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/pages/detail/article_detail.dart'
    as _i1;
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/pages/home/home_daily_news.dart'
    as _i2;
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/pages/main_screen.dart'
    as _i3;
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/pages/saved/saved.dart'
    as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    ArticleDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ArticleDetailRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ArticleDetailPage(
          key: args.key,
          article: args.article,
          isRemote: args.isRemote,
        ),
      );
    },
    HomeDailyNewsRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeDailyNewsPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MainScreen(),
      );
    },
    SavedRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SavedPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ArticleDetailPage]
class ArticleDetailRoute extends _i5.PageRouteInfo<ArticleDetailRouteArgs> {
  ArticleDetailRoute({
    _i6.Key? key,
    required _i7.ArticleModel article,
    bool isRemote = false,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          ArticleDetailRoute.name,
          args: ArticleDetailRouteArgs(
            key: key,
            article: article,
            isRemote: isRemote,
          ),
          initialChildren: children,
        );

  static const String name = 'ArticleDetailRoute';

  static const _i5.PageInfo<ArticleDetailRouteArgs> page =
      _i5.PageInfo<ArticleDetailRouteArgs>(name);
}

class ArticleDetailRouteArgs {
  const ArticleDetailRouteArgs({
    this.key,
    required this.article,
    this.isRemote = false,
  });

  final _i6.Key? key;

  final _i7.ArticleModel article;

  final bool isRemote;

  @override
  String toString() {
    return 'ArticleDetailRouteArgs{key: $key, article: $article, isRemote: $isRemote}';
  }
}

/// generated route for
/// [_i2.HomeDailyNewsPage]
class HomeDailyNewsRoute extends _i5.PageRouteInfo<void> {
  const HomeDailyNewsRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeDailyNewsRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeDailyNewsRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MainScreen]
class MainRoute extends _i5.PageRouteInfo<void> {
  const MainRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SavedPage]
class SavedRoute extends _i5.PageRouteInfo<void> {
  const SavedRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SavedRoute.name,
          initialChildren: children,
        );

  static const String name = 'SavedRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
