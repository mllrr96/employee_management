import 'package:employee_management/src/core/constant/localization/localization.dart';
import 'package:employee_management/src/core/routes/app_route.dart';
import 'package:employee_management/src/feature/settings/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  static final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) => ShadApp.materialRouter(
            themeMode: state.themeMode,
            localizationsDelegates: Localization.localizationDelegates,
            supportedLocales: Localization.supportedLocales,
            routerConfig: _appRouter.config(),
            builder: EasyLoading.init(),
            theme: ShadThemeData(
              colorScheme: const ShadVioletColorScheme.light(),
              brightness: Brightness.light,
              textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.inter),
            ),
            darkTheme: ShadThemeData(
              colorScheme: const ShadRoseColorScheme.dark(),
              brightness: Brightness.dark,
              textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.inter),
            ),
          ),
      );
}
