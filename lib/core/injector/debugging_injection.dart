import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/logs/logger.dart';

Future<void> debuggingInjection() async {
  sl.registerSingleton<Logger>(Logger()..initialize());
}
