import 'package:neuro_app/core/injector/app_injection.dart';
import 'package:neuro_app/core/services/environment/environment_info.dart';

Future<void> environmentInjection() async {
  final EnvironmentInfo env = await EnvironmentInfo.initialize();
  sl.registerSingleton<EnvironmentInfo>(env);
}
