import 'package:bac_project/core/services/api/supabase/supabase_settings.dart';
import 'package:bac_project/features/notifications/domain/entities/remote_notification.dart';
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
  if (!sl.isRegistered<Logger>()) {
    await ServiceLocator.init();
  }
  final logger = sl<Logger>();
  try {
    logger.logWarning('A background message was received: ${message.messageId}');
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    logger.logMessage('Firebase initialized');
    // TODO: Initialize Supabase
    await Supabase.initialize(url: SupabaseSettings.url, anonKey: SupabaseSettings.anonKey);
    logger.logMessage('Supabase initialized');
    sl<NotificationsBloc>().add(LoadNotificationsEvent());
    await sl<DisplayNotificationUsecase>().call(
      notification: AppNotification.fromRemoteMessage(message),
    );
    logger.logMessage('DisplayFirebaseNotificationUsecase called');
  } on Exception catch (e) {
    logger.logError('Error in firebaseMessagingBackgroundHandler: $e');
  }
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse? response) async {
  if (!sl.isRegistered<Logger>()) {
    await ServiceLocator.init();
  }
  final logger = sl<Logger>();
  logger.logWarning('A background notification response was received: ${response?.payload}');
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    logger.logMessage('Firebase initialized');

    await Supabase.initialize(url: SupabaseSettings.url, anonKey: SupabaseSettings.anonKey);

    logger.logMessage('Supabase initialized');

    if (!sl.isRegistered<DisplayNotificationUsecase>()) {
      await ServiceLocator.init();
    }

    sl<NotificationsBloc>().add(LoadNotificationsEvent());

    await Future.delayed(const Duration(milliseconds: 500));

    if (navigatorKey.currentState != null) {
      navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => const NotificationsView()));
    }
  } catch (e) {
    logger.logError('Error in onDidReceiveBackgroundNotificationResponse: $e');
  }
}

class FirebaseMessagingHandlers {
  ///
  /// [firebase messaging foreground handler]
  Future<void> onData(RemoteMessage message) async {
    await ServiceLocator.init();
    final logger = sl<Logger>();
    logger.logWarning('A foreground message was received: ${message.messageId}');
    await sl<DisplayNotificationUsecase>().call(
      notification: AppNotification.fromRemoteMessage(message),
    );
    sl<NotificationsBloc>().add(LoadNotificationsEvent());
  }

  ///
  Future<void> onTokenRefreshed(String newToken) async {
    await ServiceLocator.init();
    final logger = sl<Logger>();
    logger.logMessage('Firebase token refreshed: $newToken');
    sl<NotificationsBloc>().add(SyncNotificationsEvent());
  }

  ///
  void onDone() {}

  ///
  void onError(error) {}

  Future<void> onNotificationOpened(RemoteMessage message) async {
    if (!sl.isRegistered<Logger>()) {
      await ServiceLocator.init();
    }
    sl<Logger>().logWarning(
      'Notification opened from background/terminated state: ${message.messageId}',
    );

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
        sl<Logger>().logWarning('Navigator not ready for notification navigation');
      }
    }
  }

  /// [firebase notification initial handler]
  Future<void> onInitialNotification() async {
    if (!sl.isRegistered<Logger>()) {
      await ServiceLocator.init();
    }
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      sl<Logger>().logWarning(
        'App opened from terminated state via notification: ${initialMessage.messageId}',
      );
      // Add delay to ensure app is fully initialized
      await Future.delayed(const Duration(milliseconds: 1000));
      await onNotificationOpened(initialMessage);
    }
  }
}
