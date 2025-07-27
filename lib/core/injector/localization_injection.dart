import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:bac_project/core/services/localization/localization_cache_service.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';

Future<void> localizationInjection() async {
  //
  sl.registerSingleton<LocalizationCacheService>(LocalizationCacheService(cacheManager: sl<CacheManager>()));
  sl.registerSingleton<LocalizationManager>(LocalizationManager());

}
