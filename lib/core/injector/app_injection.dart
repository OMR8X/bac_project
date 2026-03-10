import 'package:neuro_app/core/injector/cache_injection.dart';
import 'package:neuro_app/core/injector/codepush_injection.dart';
import 'package:neuro_app/core/injector/client_injection.dart';
import 'package:neuro_app/core/injector/notifications_injection.dart';
import 'package:neuro_app/core/injector/reports_feature_injection.dart';
import 'package:neuro_app/core/injector/results_feature_inj.dart';
import 'package:neuro_app/core/injector/supabase_injection.dart';
import 'package:neuro_app/core/injector/tests_feature_inj.dart';
import 'package:neuro_app/core/injector/settings_feature_inj.dart';
import 'package:neuro_app/core/services/api/api_manager.dart';
import 'package:neuro_app/core/services/logs/logger.dart';
import 'package:get_it/get_it.dart';
import 'controllers_injection.dart';
import 'environment_injection.dart';
import 'package_info_injection.dart';
import 'paths_injection.dart';
import 'auth_injection.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ///
  static Future<void> init() async {
    if (sl.isRegistered<ApiManager>()) return;

    try {
      await injectServices();
      await initFeatures();
      await initControllers();
    } catch (e) {
      Logger.error('Error in ServiceLocator.init: $e', stackTrace: StackTrace.current);
    }
  }

  /// Services
  static Future<void> injectServices() async {
    await clientInjection();
    await supabaseInjection();
    await packageInfoInjection();
    await cacheInjection();
    await codepushInjection();
    await pathsInjection();
    await environmentInjection();
  }

  /// Features
  static Future<void> initFeatures() async {
    // await featureInjectionCallExample();
    await testsFeatureInjection();
    await resultsFeatureInjection();
    await settingsFeatureInjection();
    await notificationsFeatureInjection();
    await authFeatureInjection();
    await reportsFeatureInjection();
  }

  /// controllers
  static Future<void> initControllers() async {
    await controllersInjection();
  }
}
