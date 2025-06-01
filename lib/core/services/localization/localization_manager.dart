import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/localization/localization_cache_service.dart';

class LocalizationManager {
  static final LocalizationManager _instance = LocalizationManager._internal();
  factory LocalizationManager() => _instance;
  LocalizationManager._internal();

  late Map<String, dynamic> _content;

  Future<void> init() async {
    final cacheService = sl<LocalizationCacheService>();
    _content = await cacheService.getCachedJson();
  }

  String get(String keyPath) {
    List<String> keys = keyPath.split('.');
    dynamic current = _content;
    for (var key in keys) {
      if (current is Map<String, dynamic> && current.containsKey(key)) {
        current = current[key];
      } else {
        return keyPath;
      }
    }
    return current.toString();
  }
}
