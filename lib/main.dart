import 'dart:async';
import 'dart:ui';

import 'package:bac_project/firebase_options.dart';
import 'package:bac_project/presentation/root/views/app_root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bac_project/features/reports/domain/requests/exception_report_request.dart';
import 'package:bac_project/features/reports/domain/usecases/submit_exception_report_usecase.dart';
import 'core/injector/app_injection.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      ///
      try {
        await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      } catch (_) {}

      ///
      try {
        await ServiceLocator.init();
        await Supabase.instance.client.auth.refreshSession();
      } catch (_) {}

      // 1. Catch Flutter framework errors (UI/Widget errors)
      FlutterError.onError = (FlutterErrorDetails details) {
        _reportException(
          exceptionType: 'FlutterError',
          message: details.exceptionAsString(),
          stackTrace: details.stack?.toString(),
          trigger: 'FlutterError.onError',
        );
      };

      // 2. Catch platform dispatcher errors (async errors in platform channels)
      PlatformDispatcher.instance.onError = (error, stack) {
        _reportException(
          exceptionType: error.runtimeType.toString(),
          message: error.toString(),
          stackTrace: stack.toString(),
          trigger: 'PlatformDispatcher.onError',
        );
        return true;
      };

      ///
      runApp(AppRoot());
    },
    // 3. Catch all other Dart async errors (runZonedGuarded)
    (error, stackTrace) {
      _reportException(
        exceptionType: error.runtimeType.toString(),
        message: error.toString(),
        stackTrace: stackTrace.toString(),
        trigger: 'runZonedGuarded',
      );
    },
  );
}

void _reportException({
  required String exceptionType,
  required String message,
  String? stackTrace,
  String? trigger,
}) {
  try {
    final usecase = sl<SubmitExceptionReportUsecase>();
    usecase.call(
      ExceptionReportRequest(
        exceptionType: exceptionType,
        message: message,
        stackTrace: stackTrace,
        trigger: trigger,
      ),
    );
  } catch (_) {
    // Silently fail if reporting fails (avoid infinite loops)
  }
}
///
// 1- collect users screens activities
// 2- collect users status (online/offline)
// 3- create users table
// 4- 
///