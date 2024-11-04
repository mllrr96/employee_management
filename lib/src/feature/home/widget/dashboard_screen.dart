import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        HomeRoute(),
        // SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(CupertinoIcons.home),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(CupertinoIcons.settings),
            ),
          ],
        ),
    );
}
