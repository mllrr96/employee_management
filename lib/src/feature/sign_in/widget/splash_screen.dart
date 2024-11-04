import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // final Session? session = getIt<SupabaseClient>().auth.currentSession;
    // final isAuthenticated = session != null;
    // if (isAuthenticated) {
    //   context.router.replaceAll([HomeRoute()]);
    // } else {
      context.router.replaceAll([const SignInRoute()]);
    // }
    super.initState();
  }
  @override
  Widget build(BuildContext context) => const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
}