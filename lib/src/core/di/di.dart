import 'package:employee_management/src/core/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';


final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async => await getIt.init();
