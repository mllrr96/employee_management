import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AutoTabsScaffold(
        routes: const [
          AdminHomeRoute(),
          // HomeRoute(),
          ProfileRoute(),
          NotificationRoute(),
          ScheduleRoute(),
          SettingsRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) => BottomNavigationBar(
          selectedLabelStyle: const TextStyle(fontSize: 1),
          unselectedLabelStyle: const TextStyle(fontSize: 1),
          type: BottomNavigationBarType.fixed,
          currentIndex: tabsRouter.activeIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(CupertinoIcons.home),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.account_circle),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.notifications_active),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.date_range),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(CupertinoIcons.settings),
            ),
          ],
        ),
      );
}
