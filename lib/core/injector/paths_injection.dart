import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/paths/app_paths.dart';

Future<void> pathsInjection() async {
  //
  sl.registerSingleton<AppPaths>(AppPaths());
  //
  await sl<AppPaths>().init();
}
