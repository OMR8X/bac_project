import 'dart:io';

import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/logs/logger.dart';
import 'package:bac_project/features/notifications/domain/requests/subscribe_to_topic_request.dart';
import 'package:bac_project/features/notifications/domain/requests/unsubscribe_from_topic_request.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/features/notifications/data/handlers/firebase_messaging_handlers.dart';
import 'package:bac_project/features/notifications/data/settings/app_local_notifications_settings.dart';
import 'package:bac_project/features/notifications/data/settings/firebase_messaging_settings.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/entities/app_notification.dart';

abstract class NotificationsRemoteDatasource {
  ///
  Future<Unit> initializeLocalNotification();
  Future<Unit> initializeFirebaseNotification();

  ///
  Future<Unit> displayNotification({
    required AppNotification notification,
    bool oneTimeNotification = true,
    NotificationDetails? details,
  });

  ///
  Future<Unit> subscribeToTopic(SubscribeToTopicRequest request);
  Future<Unit> unsubscribeToTopic(UnsubscribeFromTopicRequest request);

  ///
  Future<String> getDeviceToken();
  Future<Unit> deleteDeviceToken();
}

class NotificationsRemoteDatasourceImplements implements NotificationsRemoteDatasource {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationsRemoteDatasourceImplements();

  @override
  Future<Unit> initializeLocalNotification() async {
    await _requestNotificationPermission();

    for (var channel in AppLocalNotificationsSettings.channels) {
      await _createNotificationsChannel(channel);
    }

    await _localNotificationsPlugin.initialize(
      AppLocalNotificationsSettings.settings,
      onDidReceiveNotificationResponse: (response) {},
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );

    return unit;
  }

  @override
  Future<Unit> initializeFirebaseNotification() async {
    await _firebaseMessaging.requestPermission();

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: AppAppNotificationsSettings.showAlert,
      badge: AppAppNotificationsSettings.showBadge,
      sound: AppAppNotificationsSettings.showSound,
    );

    // Set up handlers
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(
      onDataHandler,
      onDone: onDoneHandler,
      onError: onErrorHandler,
    );
    FirebaseMessaging.instance.onTokenRefresh.listen(onTokenRefreshedHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(onNotificationOpenedHandler);

    // Handle initial notification (when app is opened from terminated state)
    await onInitialNotificationHandler();

    Logger.warning('Firebase token: ${await getDeviceToken()}');
    return unit;
  }

  Future<Unit> _createNotificationsChannel(AndroidNotificationChannel channel) async {
    final androidImplementation =
        _localNotificationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.createNotificationChannel(channel);
    return unit;
  }

  @override
  Future<Unit> displayNotification({
    required AppNotification notification,
    bool oneTimeNotification = true,
    NotificationDetails? details,
  }) async {
    if (!notification.isValid()) {
      Logger.error('Notification is not valid: ${notification.toJson()}');
      return unit;
    }
    await _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch % 2147483647, // Ensure it fits in int32
      notification.title,
      notification.body,
      details ?? AppLocalNotificationsSettings.defaultNotificationsDetails(),
    );

    return unit;
  }

  @override
  Future<Unit> subscribeToTopic(SubscribeToTopicRequest request) async {
    await _firebaseMessaging.subscribeToTopic(request.firebaseTopicName);
    return unit;
  }

  @override
  Future<Unit> unsubscribeToTopic(UnsubscribeFromTopicRequest request) async {
    await _firebaseMessaging.unsubscribeFromTopic(request.firebaseTopicName);
    return unit;
  }

  @override
  Future<Unit> deleteDeviceToken() async {
    await _firebaseMessaging.deleteToken();
    return unit;
  }

  @override
  Future<String> getDeviceToken() async {
    final token =
        Platform.isIOS
            ? await _firebaseMessaging.getAPNSToken()
            : await _firebaseMessaging.getToken();
    if (token == null) throw Exception("FCM token is null");
    return token;
  }

  Future<void> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.notification.status;
      if (status.isDenied) {
        await Permission.notification.request();
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
      }
    } else if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);
    }
  }
}
