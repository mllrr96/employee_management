import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// List of extensions for [BuildContext]
extension ContextExtension on BuildContext {

  double get bottomPadding => MediaQuery.of(this).viewPadding.bottom;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  SystemUiOverlayStyle get adaptiveUiOverlay => SystemUiOverlayStyle(
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: ShadTheme.of(this).cardTheme.backgroundColor,
        statusBarColor: ShadTheme.of(this).cardTheme.backgroundColor,
      );
}
