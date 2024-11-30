import 'dart:async';
import 'package:employee_management/firebase_options.dart';
import 'package:employee_management/src/core/di/di.dart';
import 'package:employee_management/src/core/utils/app_bloc_observer.dart';
import 'package:employee_management/src/core/utils/bloc_transformer.dart';
import 'package:employee_management/src/core/utils/logger.dart';
import 'package:employee_management/src/feature/employee_home/bloc/check_bloc.dart';
import 'package:employee_management/src/feature/initialization/widget/app.dart';
import 'package:employee_management/src/feature/initialization/widget/initialization_failed_app.dart';
import 'package:employee_management/src/feature/settings/bloc/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class AppRunner {
  const AppRunner(this.logger);

  /// The logger instance
  final Logger logger;

  /// Start the initialization and in case of success run application
  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    // Preserve splash screen
    binding.deferFirstFrame();

    // Override logging
    FlutterError.onError = logger.logFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError =
        logger.logPlatformDispatcherError;

    // Setup bloc observer and transformer
    Bloc.observer = AppBlocObserver(logger);
    Bloc.transformer = SequentialBlocTransformer().transform;

    Future<void> initializeAndRun() async {
      try {

        // Configure dependency injection
        await configureInjection();

        // Initialize Firebase
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

        // Attach this widget to the root of the tree.
        runApp(
          MultiBlocProvider(
            providers: [
              BlocProvider<CheckBloc>(
                create: (context) => CheckBloc.instance,
              ),
              BlocProvider<ThemeCubit>(
                create: (context) => ThemeCubit.instance..loadTheme(),
              ),
            ],
            child: const App(),
          ),
        );
      } catch (e, stackTrace) {
        logger.error('Initialization failed', error: e, stackTrace: stackTrace);
        runApp(
          InitializationFailedApp(
            error: e,
            stackTrace: stackTrace,
            onRetryInitialization: initializeAndRun,
          ),
        );
      } finally {
        // Allow rendering
        binding.allowFirstFrame();
      }
    }

    // Run the app
    await initializeAndRun();
  }
}
