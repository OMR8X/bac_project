import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/environment/environment_info.dart';

Future<void> environmentInjection() async {
  final EnvironmentInfo env = await EnvironmentInfo.initialize();
  sl.registerSingleton<EnvironmentInfo>(env);
}
