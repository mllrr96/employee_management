import 'package:employee_management/src/core/utils/layout/window_size.dart';
import 'package:employee_management/src/feature/initialization/widget/material_context.dart';
import 'package:employee_management/src/feature/settings/widget/settings_scope.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: const SettingsScope(
          child: WindowSizeScope(child: MaterialContext()),
        ),
      );
}
