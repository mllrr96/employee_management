import 'package:employee_management/src/core/constant/localization/localization.dart';
import 'package:employee_management/src/core/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatelessWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) => ShadApp.materialRouter(
        themeMode: ThemeMode.system,
        localizationsDelegates: Localization.localizationDelegates,
        supportedLocales: Localization.supportedLocales,
        routerConfig: _appRouter.config(),
        builder: EasyLoading.init(),
        theme: ShadThemeData(
            colorScheme: const ShadVioletColorScheme.light(),
            brightness: Brightness.light,
            textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.inter),),
      );
}
