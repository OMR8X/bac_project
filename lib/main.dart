import 'package:bac_project/firebase_options.dart';
import 'package:bac_project/presentation/root/views/app_root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/injector/app_injection.dart';

Future<void> main() async {
  ///
  WidgetsFlutterBinding.ensureInitialized();

  ///
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {}

  ///
  try {
    await ServiceLocator.init();
    await Supabase.instance.client.auth.refreshSession();
  } catch (_) {}
  // LocalizationManager migrated; ARB-based localization loaded at build time.

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
external links  : Advertising, Website, Instagram, Facebook, etc.
internal links  : Open screen, Open test, Open notification, etc.
*/


