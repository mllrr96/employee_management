import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final isAuthenticated = FirebaseAuth.instance.currentUser != null;

    if (isAuthenticated) {
      context.router.replaceAll([const HomeRoute()]);
    } else {
      context.router.replaceAll([const SignInRoute()]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: context.adaptiveUiOverlay,
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      );
}
