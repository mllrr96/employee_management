import 'dart:developer';
import 'package:employee_management/src/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

part 'theme_cubit.freezed.dart';

@injectable
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._sharedPreferences)
      : super(const ThemeState.initial(ThemeMode.system));

  void loadTheme() {
    try {
      final themeString = _sharedPreferences.getInt('themeIndex');
      ThemeMode themeMode;
      switch (themeString) {
        case 0:
          themeMode = ThemeMode.system;
        case 1:
          themeMode = ThemeMode.light;
        case 2:
          themeMode = ThemeMode.dark;
        default:
          themeMode = ThemeMode.system;
      }
      emit(ThemeState.initial(themeMode));
    } catch (e) {
      log('Error loading theme: $e');
      emit(const ThemeState.initial(ThemeMode.system));
    }
  }

  void changeTheme(ThemeMode themeMode) {
    try {
      _sharedPreferences.setInt('themeIndex', themeMode.index);
    } catch (e) {
      log('Error saving theme: $e');
    } finally {
      emit(ThemeState.initial(themeMode));
    }
  }

  static ThemeCubit get instance => getIt<ThemeCubit>();
  final SharedPreferences _sharedPreferences;
}
