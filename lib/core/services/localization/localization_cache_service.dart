import 'dart:convert';

import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:flutter/services.dart';

class LocalizationCacheService {
  static const _cacheKey = 'localized_json';
  final CacheManager cacheManager;

  LocalizationCacheService({required this.cacheManager});

  Future<void> loadAndCacheJson(String localeCode) async {
    final String jsonStr = await rootBundle.loadString('assets/langs/$localeCode.json');
    cacheManager().write(_cacheKey, jsonStr);
  }

  Future<Map<String, dynamic>> getCachedJson() async {
    final jsonStr = await cacheManager().read(_cacheKey);
    return json.decode(jsonStr);
  }
}
