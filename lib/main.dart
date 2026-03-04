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

/// Reports an exception to the backend using the reports feature.
/// This is fire-and-forget to avoid blocking the main thread.
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

// class ErrorsCopier {
//   ///
//   // Private constructor for singleton pattern
//   ErrorsCopier._privateConstructor();

//   // The single instance
//   static final ErrorsCopier _instance = ErrorsCopier._privateConstructor();

//   // Factory constructor to return the same instance every time
//   factory ErrorsCopier() => _instance;

//   ///
//   final List<String> errors = List.empty(growable: true);

//   static List<String> get errorsList => _instance.errors;

//   ///
//   Future<void> addErrorLogs(String details) async {
//     errors.add(details);
//   }
// }


/*
external links  : Advertising, Website, Instagram, Facebook, etc.
internal links  : Open screen, Open test, Open notification, etc.

when building an apk with shorebird we use command:
flutter clean && flutter pub get && shorebird release android --artifact apk          

when building an apk with normal flutter we use command:
flutter clean && flutter pub get && flutter build apk --release

when pathcing an app with normal flutter we use command (we always spicify android):
shorebird patch android

flutter clean && flutter build appbundle --release


Naming :
1. using - instade of _
example: moatmat_teacher.apk => moatmat-teacher.apk
2. use the main name
example: moatmat_teacher => teacher.apk
3. append version details:
teacher.apk => teacher(1.0.0+5).apk
4. if build apk with shorebird we mark it with "sp":
teacher-sp(1.0.0+5).apk

*/


