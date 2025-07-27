import 'package:bac_project/core/services/localization/localization_cache_service.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';
import 'package:bac_project/presentation/root/views/app_root.dart';
import 'package:flutter/material.dart';
import 'core/injector/app_injection.dart';

void main() async {
  ///
  WidgetsFlutterBinding.ensureInitialized();

  // try {
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // } catch (e) {}

  ///
  await ServiceLocator.init();
  //
  await sl<LocalizationManager>().init();
  await sl<LocalizationCacheService>().loadAndCacheJson('ar');
  // ///
  // await sl<AppBackgroundService>().initializeBackgroundServiceForUploads();

  // ///
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // ///
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  ///
  runApp(AppRoot());
}

class ErrorsCopier {
  ///
  // Private constructor for singleton pattern
  ErrorsCopier._privateConstructor();

  // The single instance
  static final ErrorsCopier _instance = ErrorsCopier._privateConstructor();

  // Factory constructor to return the same instance every time
  factory ErrorsCopier() => _instance;

  ///
  final List<String> errors = List.empty(growable: true);

  static List<String> get errorsList => _instance.errors;

  ///
  Future<void> addErrorLogs(String details) async {
    errors.add(details);
  }
}
/*
cd asteroid_bomber && flutter clean && cd ..
cd authify && flutter clean && cd ..
cd bac && flutter clean && cd ..
cd bac_project && flutter clean && cd ..
cd base && flutter clean && cd ..
cd car_brand && flutter clean && cd ..
cd omr8x && flutter clean && cd ..
cd pages && flutter clean && cd ..
cd planets && flutter clean && cd ..
*/
