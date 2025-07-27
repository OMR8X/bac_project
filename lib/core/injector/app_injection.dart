import 'package:bac_project/core/injector/cache_injection.dart';
import 'package:bac_project/core/injector/localization_injection.dart';
import 'package:bac_project/core/injector/tests_feature_inj.dart';
import 'package:get_it/get_it.dart';

import 'controllers_injection.dart';
import 'debugging_injection.dart';
import 'package_info_injection.dart';
import 'paths_injection.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ///
  static Future<void> init() async {
    await injectServices();
    await initFeatures();
    await initControllers();
  }

  /// Services
  static Future<void> injectServices() async {
    await packageInfoInjection();
    await cacheInjection();
    await localizationInjection();
    await pathsInjection();
    await debuggingInjection();
  }

  /// Features
  static Future<void> initFeatures() async {
    // await featureInjectionCallExample();
    await testsFeatureInjection();
  }

  /// controllers
  static Future<void> initControllers() async {
    await controllersInjection();
  }
}
