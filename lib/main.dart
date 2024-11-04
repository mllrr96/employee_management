import 'dart:async';

import 'package:employee_management/src/core/utils/logger.dart';
import 'package:employee_management/src/feature/initialization/logic/app_runner.dart';

void main() {
  final logger = DefaultLogger(const LoggingOptions(useDebugPrint: true));

  runZonedGuarded(
    () => AppRunner(logger).initializeAndRun(),
    logger.logZoneError,
  );
}
