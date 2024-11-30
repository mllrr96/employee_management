import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/core/utils/loading.dart';
import 'package:employee_management/src/feature/settings/bloc/theme_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                children: [
                  Text(
                    'Theme Mode',
                  ),
                ],
              ),
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) => SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<ThemeMode>(
                    onSelectionChanged: (value) {
                      if (value.isNotEmpty) {
                        context.read<ThemeCubit>().changeTheme(value.first);
                      }
                    },
                    segments: ThemeMode.values
                        .map(
                          (e) => ButtonSegment<ThemeMode>(
                            value: e,
                            label: Text(e.name.capitalize),
                          ),
                        )
                        .toList(),
                    selected: {state.themeMode},
                  ),
                ),
              ),
              const Spacer(),
              ShadButton.destructive(
                size: ShadButtonSize.lg,
                width: double.infinity,
                onPressed: () async {
                  final confirmDelete = await showOkCancelAlertDialog(
                    context: context,
                    title: 'Sign Out',
                    message: 'Are you sure you want to sign out?',
                    okLabel: 'Sign Out',
                    isDestructiveAction: true,
                  );
                  if (confirmDelete != OkCancelResult.ok) return;
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

extension on String {
  String get capitalize => this[0].toUpperCase() + substring(1);
}
