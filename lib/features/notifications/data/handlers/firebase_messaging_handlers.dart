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
import 'notifications_actions_handlers.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Logger.warning("Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {");
  Logger.warning('A background message was received: ${message.messageId}');
  try {
    /// initialize services
    await ServiceLocator.init();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await Supabase.initialize(url: SupabaseSettings.url, anonKey: SupabaseSettings.anonKey);

    /// create notification with additional safety checks
    final notification = AppNotification.fromRemoteMessage(message);

    /// display notification
    await sl<DisplayNotificationUsecase>().call(
      notification: notification,
    );
  } catch (e, stackTrace) {
    Logger.error('Error in firebaseMessagingBackgroundHandler: $e\nStack: $stackTrace');
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
  try {
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
  } catch (e) {
    Logger.error('Error in onNotificationOpenedHandler: $e');
  }
}

/// [firebase notification initial handler]
@pragma('vm:entry-point')
Future<void> onInitialNotificationHandler() async {
  Logger.warning('App opened from terminated state via notification');
  try {
    await ServiceLocator.init();
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // Add delay to ensure app is fully initialized
      await Future.delayed(const Duration(milliseconds: 1000));
      await onNotificationOpenedHandler(initialMessage);
    }
  } catch (e) {
    Logger.error('Error in onInitialNotificationHandler: $e');
  }
}

@pragma('vm:entry-point')
Future<void> onDidReceiveNotificationResponse(NotificationResponse? response) async {
  Logger.warning("=== FOREGROUND NOTIFICATION RESPONSE START ===");
  try {
    // Initialize services for action handling
    await ServiceLocator.init();
    await Supabase.initialize(url: SupabaseSettings.url, anonKey: SupabaseSettings.anonKey);

    await handleNotificationActions(response);
  } catch (e) {
    Logger.error('Error in onDidReceiveNotificationResponse: $e');
  }
}

@pragma('vm:entry-point')
Future<void> onDidReceiveBackgroundNotificationResponse(NotificationResponse? response) async {
  Logger.warning("=== BACKGROUND NOTIFICATION RESPONSE START ===");
  try {
    // Initialize services for action handling
    await ServiceLocator.init();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await Supabase.initialize(url: SupabaseSettings.url, anonKey: SupabaseSettings.anonKey);

    await handleNotificationActions(response);
  } catch (e) {
    Logger.error('Error in onDidReceiveBackgroundNotificationResponse: $e');
  }
}
