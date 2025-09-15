import 'dart:io';

import 'package:bac_project/core/services/api/supabase/supabase_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bac_project/core/constant/navigation_key.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/features/notifications/domain/requests/register_device_token_request.dart';
import 'package:bac_project/features/notifications/domain/usecases/display_firebase_notification_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/register_device_token_usecase.dart';
import 'package:bac_project/presentation/notifications/state/explore_notifications/notifications_bloc.dart';
import 'package:bac_project/presentation/notifications/views/notifications_view.dart';
import 'package:bac_project/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    debugPrint('A background message was received: ${message.messageId}');
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    debugPrint('Firebase initialized');

    await Supabase.initialize(url: SupabaseSettings.url, anonKey: SupabaseSettings.anonKey);

    debugPrint('Supabase initialized');

    if (!sl.isRegistered<DisplayFirebaseNotificationUsecase>()) {
      await ServiceLocator.init();
    }

    sl<ExploreNotificationsBloc>().add(LoadNotificationsEvent());
    await sl<DisplayFirebaseNotificationUsecase>().call(message: message);
    debugPrint('DisplayFirebaseNotificationUsecase called');
  } on Exception catch (e) {
    debugPrint('Error in firebaseMessagingBackgroundHandler: $e');
  }
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse? response) async {
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    debugPrint('Firebase initialized');

    await Supabase.initialize(url: SupabaseSettings.url, anonKey: SupabaseSettings.anonKey);

    debugPrint('Supabase initialized');

    if (!sl.isRegistered<DisplayFirebaseNotificationUsecase>()) {
      await ServiceLocator.init();
    }

    sl<ExploreNotificationsBloc>().add(LoadNotificationsEvent());

    await Future.delayed(const Duration(milliseconds: 500));

    if (navigatorKey.currentState != null) {
      navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => const NotificationsView()));
    }
  } catch (e) {
    debugPrint('Error in onDidReceiveBackgroundNotificationResponse: $e');
  }
}

class FirebaseMessagingHandlers {
  ///
  /// [firebase messaging foreground handler]
  Future<void> onData(RemoteMessage message) async {
    debugPrint('A foreground message was received: ${message.messageId}');
    await sl<DisplayFirebaseNotificationUsecase>().call(message: message);
    sl<ExploreNotificationsBloc>().add(LoadNotificationsEvent());
    debugPrint('DisplayFirebaseNotificationUsecase called');
  }

  ///
  Future<void> onTokenRefreshed(String newToken) async {
    final platform = Platform.isAndroid ? 'android' : 'ios';

    await sl<RegisterDeviceTokenUsecase>().call(
      RegisterDeviceTokenRequest(deviceToken: newToken, platform: platform),
    );
  }

  ///
  void onDone() {}

  ///
  void onError(error) {}

  Future<void> onNotificationOpened(RemoteMessage message) async {
    debugPrint('Notification opened from background/terminated state: ${message.messageId}');

    // Refresh notifications
    sl<ExploreNotificationsBloc>().add(LoadNotificationsEvent());

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
        debugPrint('Navigator not ready for notification navigation');
      }
    }
  }

  /// [firebase notification initial handler]
  Future<void> onInitialNotification() async {
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      debugPrint('App opened from terminated state via notification: ${initialMessage.messageId}');
      // Add delay to ensure app is fully initialized
      await Future.delayed(const Duration(milliseconds: 1000));
      await onNotificationOpened(initialMessage);
    }
  }
}
