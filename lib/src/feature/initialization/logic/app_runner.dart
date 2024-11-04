import 'dart:async';
import 'package:employee_management/src/core/di/di.dart';
import 'package:employee_management/src/core/utils/app_bloc_observer.dart';
import 'package:employee_management/src/core/utils/bloc_transformer.dart';
import 'package:employee_management/src/core/utils/logger.dart';
import 'package:employee_management/src/feature/initialization/widget/app.dart';
import 'package:employee_management/src/feature/initialization/widget/initialization_failed_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template app_runner}
/// A class which is responsible for initialization and running the app.
/// {@endtemplate}
final class AppRunner {
  /// {@macro app_runner}
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
    WidgetsBinding.instance.platformDispatcher.onError = logger.logPlatformDispatcherError;

    // Setup bloc observer and transformer
    Bloc.observer = AppBlocObserver(logger);
    Bloc.transformer = SequentialBlocTransformer().transform;

    Future<void> initializeAndRun() async {
      try {
        await configureInjection();
        // Attach this widget to the root of the tree.
        runApp(const App());
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
