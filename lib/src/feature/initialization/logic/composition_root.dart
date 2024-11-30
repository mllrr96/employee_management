import 'package:clock/clock.dart';
import 'package:employee_management/src/core/constant/config.dart';
import 'package:employee_management/src/core/utils/error_tracking_manager/error_tracking_manager.dart';
import 'package:employee_management/src/core/utils/error_tracking_manager/sentry_tracking_manager.dart';
import 'package:employee_management/src/core/utils/logger.dart';
import 'package:employee_management/src/feature/initialization/model/dependencies_container.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class CompositionRoot {
  /// {@macro composition_root}
  const CompositionRoot(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final Logger logger;

  /// Composes dependencies and returns result of composition.
  Future<CompositionResult> compose() async {
    final stopwatch = clock.stopwatch()..start();

    logger.info('Initializing dependencies...');
    // initialize dependencies
    final dependencies = await DependenciesFactory(config, logger).create();
    logger.info('Dependencies initialized');

    stopwatch.stop();
    final result = CompositionResult(
      dependencies: dependencies,
      millisecondsSpent: stopwatch.elapsedMilliseconds,
    );

    return result;
  }
}

/// {@template composition_result}
/// Result of composition
///
/// {@macro composition_process}
/// {@endtemplate}
final class CompositionResult {
  /// {@macro composition_result}
  const CompositionResult({
    required this.dependencies,
    required this.millisecondsSpent,
  });

  /// The dependencies container
  final DependenciesContainer dependencies;

  /// The number of milliseconds spent
  final int millisecondsSpent;

  @override
  String toString() => '$CompositionResult('
      'dependencies: $dependencies, '
      'millisecondsSpent: $millisecondsSpent'
      ')';
}

/// {@template factory}
/// Factory that creates an instance of [T].
/// {@endtemplate}
abstract class Factory<T> {
  /// Creates an instance of [T].
  T create();
}

/// Factory that creates an instance of [T] asynchronously.
abstract class AsyncFactory<T> {
  /// Creates an instance of [T].
  Future<T> create();
}

/// Factory that creates an instance of [DependenciesContainer].
class DependenciesFactory extends AsyncFactory<DependenciesContainer> {
  /// {@macro dependencies_factory}
  DependenciesFactory(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final Logger logger;

  @override
  Future<DependenciesContainer> create() async {

    final packageInfo = await PackageInfo.fromPlatform();
    final errorTrackingManager = await ErrorTrackingManagerFactory(config, logger).create();

    return DependenciesContainer(
      logger: logger,
      config: config,
      errorTrackingManager: errorTrackingManager,
      packageInfo: packageInfo,
    );
  }
}

/// Factory that creates an instance of [ErrorTrackingManager].
class ErrorTrackingManagerFactory extends AsyncFactory<ErrorTrackingManager> {
  ErrorTrackingManagerFactory(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final Logger logger;

  @override
  Future<ErrorTrackingManager> create() async {
    final errorTrackingManager = SentryTrackingManager(
      logger,
      sentryDsn: config.sentryDsn,
      environment: config.environment.value,
    );

    if (config.enableSentry && kReleaseMode) {
      await errorTrackingManager.enableReporting();
    }

    return errorTrackingManager;
  }
}
