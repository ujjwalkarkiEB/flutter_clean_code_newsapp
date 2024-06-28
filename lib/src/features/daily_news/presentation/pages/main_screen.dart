import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_code_news_app/src/core/config/route/app_route.gr.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        const HomeDailyNewsRoute(),
        const SavedRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          backgroundColor: Colors.purple.shade50,
          type: BottomNavigationBarType.fixed,
          elevation: 14,
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) {
            tabsRouter.setActiveIndex(index);
          },
          selectedIconTheme: const IconThemeData(color: Colors.purple),
          iconSize: 25,
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: 'Saved', icon: Icon(Icons.favorite_outlined)),
          ],
        );
      },
    );
  }
}
