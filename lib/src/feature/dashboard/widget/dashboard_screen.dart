import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:employee_management/src/core/widget/employee_icons_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor:
              context.isDarkMode ? Colors.black : Colors.white,
          statusBarColor: context.isDarkMode ? Colors.black : Colors.white,
        ),
        child: AutoTabsScaffold(
          homeIndex: 0,
          routes: [
            if (FirebaseAuth.instance.currentUser!.email!.contains('auis.edu.krd'))
            const AdminHomeRoute(),
            if (!FirebaseAuth.instance.currentUser!.email!.contains('auis.edu.krd'))
            const HomeRoute(),
            const ProfileRoute(),
            const NotificationRoute(),
            const ScheduleRoute(),
            const SettingsRoute(),
          ],
          bottomNavigationBuilder: (_, tabsRouter) => Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              selectedLabelStyle: const TextStyle(fontSize: 0),
              unselectedLabelStyle: const TextStyle(fontSize: 0),
              type: BottomNavigationBarType.fixed,
              currentIndex: tabsRouter.activeIndex,
              selectedItemColor:
                  ShadTheme.of(context).primaryButtonTheme.backgroundColor,
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
          ),
        ),
      );
}
