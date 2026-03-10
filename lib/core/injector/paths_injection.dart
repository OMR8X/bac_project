import 'package:neuro_app/core/injector/app_injection.dart';
import 'package:neuro_app/core/services/paths/app_paths.dart';

Future<void> pathsInjection() async {
  //
  sl.registerSingleton<AppPaths>(AppPaths());
  //
  await sl<AppPaths>().init();
}
