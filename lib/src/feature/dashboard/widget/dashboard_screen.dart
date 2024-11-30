import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/core/widget/employee_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
          selectedLabelStyle: const TextStyle(fontSize: 0),
          unselectedLabelStyle: const TextStyle(fontSize: 0),
          type: BottomNavigationBarType.fixed,
          currentIndex: tabsRouter.activeIndex,
          selectedItemColor: ShadTheme.of(context).primaryButtonTheme.backgroundColor,
          // unselectedItemColor: Colors.grey,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(EmployeeIcons.home),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(EmployeeIcons.profile),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(EmployeeIcons.notification),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(EmployeeIcons.schedule),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(EmployeeIcons.settings),
            ),
          ],
        ),
      );
}
