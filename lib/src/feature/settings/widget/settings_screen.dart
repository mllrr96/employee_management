import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/core/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings',style: TextStyle(
            fontSize: 16,
            fontFamily: 'Roboto',
          ),),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ShadButton.destructive(
                size: ShadButtonSize.lg,
                width: double.infinity,
                onPressed: () async {
                  await loading();
                  try {
                    await FirebaseAuth.instance.signOut();
                    await dismissLoading();
                    if (context.mounted) {
                      await context.router.replaceAll([const SignInRoute()]);
                    }
                  } on FirebaseAuthException catch (e) {
                    await dismissLoading();
                    if (context.mounted) {
                      ShadToaster.of(context).show(
                        ShadToast.destructive(
                          title: const Text('Failed to logout'),
                          description: Text(e.message ?? 'An error occurred'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      );
}
