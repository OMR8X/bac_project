import 'package:bac_project/core/services/api/supabase/supabase_settings.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:bac_project/features/notifications/domain/usecases/display_notification_usecase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bac_project/core/constant/navigation_key.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/presentation/notifications/state/explore_notifications/notifications_bloc.dart';
import 'package:bac_project/presentation/notifications/views/notifications_view.dart';
import 'package:bac_project/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/logs/logger.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Logger.warning('A background message was received: ${message.messageId}');
  try {
    await ServiceLocator.init();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    Logger.message('Firebase initialized');
    await Supabase.initialize(url: SupabaseSettings.url, anonKey: SupabaseSettings.anonKey);
    Logger.message('Supabase initialized');
    sl<NotificationsBloc>().add(LoadNotificationsEvent());
    await sl<DisplayNotificationUsecase>().call(
      notification: AppNotification.fromRemoteMessage(message),
    );
    Logger.message('DisplayFirebaseNotificationUsecase called');
  } on Exception catch (e) {
    Logger.error('Error in firebaseMessagingBackgroundHandler: $e');
  }
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse? response) async {
  Logger.warning('A background notification response was received: ${response?.payload}');
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    Logger.message('Firebase initialized');

    await Supabase.initialize(url: SupabaseSettings.url, anonKey: SupabaseSettings.anonKey);

    Logger.message('Supabase initialized');

    if (!sl.isRegistered<DisplayNotificationUsecase>()) {
      await ServiceLocator.init();
    }

    sl<NotificationsBloc>().add(LoadNotificationsEvent());

    await Future.delayed(const Duration(milliseconds: 500));

    if (navigatorKey.currentState != null) {
      navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => const NotificationsView()));
    }
  } catch (e) {
    Logger.error('Error in onDidReceiveBackgroundNotificationResponse: $e');
  }
}

///
/// [firebase messaging foreground handler]
@pragma('vm:entry-point')
Future<void> onDataHandler(RemoteMessage message) async {
  Logger.warning('A foreground message was received: ${message.messageId}');
  await ServiceLocator.init();
  sl<NotificationsBloc>().add(
    DisplayForegroundNotificationsEvent(message: message),
  );
}

///
@pragma('vm:entry-point')
Future<void> onTokenRefreshedHandler(String newToken) async {
  Logger.message('Firebase token refreshed: $newToken');
  await ServiceLocator.init();
  sl<NotificationsBloc>().add(SyncNotificationsEvent());
}

///
@pragma('vm:entry-point')
void onDoneHandler() {}

///
@pragma('vm:entry-point')
void onErrorHandler(error) {}

@pragma('vm:entry-point')
Future<void> onNotificationOpenedHandler(RemoteMessage message) async {
  Logger.warning('Notification opened from background state: ${message.messageId}');
  await ServiceLocator.init();

  // Refresh notifications
  sl<NotificationsBloc>().add(LoadNotificationsEvent());

  // Add delay to ensure the app is fully resumed and navigation context is ready
  await Future.delayed(const Duration(milliseconds: 300));

  // Check if navigator is ready
  if (navigatorKey.currentState?.mounted == true) {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => const NotificationsView()));
  } else {
    // If navigator is not ready, wait and try again
    await Future.delayed(const Duration(milliseconds: 500));
    if (navigatorKey.currentState?.mounted == true) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (_) => const NotificationsView()),
      );
    } else {
      Logger.warning('Navigator not ready for notification navigation');
    }
  }
}

/// [firebase notification initial handler]
@pragma('vm:entry-point')
Future<void> onInitialNotificationHandler() async {
  Logger.warning('App opened from terminated state via notification');
  await ServiceLocator.init();
  final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    // Add delay to ensure app is fully initialized
    await Future.delayed(const Duration(milliseconds: 1000));
    await onNotificationOpenedHandler(initialMessage);
  }
}
