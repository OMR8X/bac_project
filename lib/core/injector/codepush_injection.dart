import 'package:neuro_app/core/injector/app_injection.dart';
import 'package:neuro_app/core/services/codepush/codepush_manager.dart';

import '../services/codepush/codepush_client.dart';

Future<void> codepushInjection() async {
  //
  sl.registerSingleton<CodePushClient>(ShorebirdClient());
  sl.registerSingleton<CodePushManager>(CodePushManager(sl<CodePushClient>()));
}
