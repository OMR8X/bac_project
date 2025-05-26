import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/cache/cache_manager.dart';

import '../services/cache/cache_client.dart';

Future<void> cacheInjection() async {
  //
  sl.registerSingleton<CacheClient>(HiveClient());
  sl.registerSingleton<CacheManager>(CacheManager(sl<CacheClient>()));
  //
  await sl<CacheManager>().init();
}
