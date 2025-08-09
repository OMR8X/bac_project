import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/debug/debugging_manager.dart';

Future<void> debuggingInjection() async {
  sl.registerSingleton<DebuggingManager>(DebuggingManager()..init());
}
