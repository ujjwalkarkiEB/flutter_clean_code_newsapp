import 'package:auto_route/auto_route.dart';

import 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, initial: true, children: [
          AutoRoute(page: HomeDailyNewsRoute.page, initial: true),
          AutoRoute(page: SavedRoute.page),
        ]),
        AutoRoute(page: ArticleDetailRoute.page),
      ];
}
