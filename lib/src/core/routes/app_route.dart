import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(
          page: DashboardRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: AdminHomeRoute.page),
            AutoRoute(page: NotificationRoute.page),
            AutoRoute(page: ProfileRoute.page),
            AutoRoute(page: ScheduleRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: AddCheckRoute.page),
        AutoRoute(page: UpdateProfileRoute.page),
        AutoRoute(page: ChangePasswordRoute.page),

        AutoRoute(page: GenerateReportsRoute.page),
        AutoRoute(page: ReportsPreviewRoute.page),
        AutoRoute(page: ManageEmployeesRoute.page),
        AutoRoute(page: ManageAdminsRoute.page),
        AutoRoute(page: ManageScheduleRoute.page),
        AutoRoute(page: AddAdminRoute.page),
        AutoRoute(page: AddEmployeeRoute.page),
      ];
}
