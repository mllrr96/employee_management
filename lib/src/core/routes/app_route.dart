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
            // AutoRoute(page: SettingsRoute.page),
          ],
        ),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: AddCheckRoute.page),
        AutoRoute(page: UpdateProfileRoute.page),
        AutoRoute(page: ChangePasswordRoute.page),
        // AutoRoute(page: SelectInstructorsRoute.page),
      ];

  // @override
  // List<AutoRouteGuard> get guards => [
  //       AutoRouteGuard.simple(
  //         (resolver, router) {
  //           final isAuthenticated = getIt<SupabaseClient>().auth.currentSession != null;
  //           if (isAuthenticated || resolver.routeName == SignInRoute.name) {
  //             resolver.next();
  //           } else {
  //             router.pushAll([SignInRoute()]);
  //           }
  //         },
  //       ),
  //     ];
}
