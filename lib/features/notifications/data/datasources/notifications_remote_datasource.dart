import 'dart:io';

import 'package:bac_project/features/notifications/data/responses/subscribe_to_topic_response.dart';
import 'package:bac_project/features/notifications/data/responses/unsubscribe_from_topic_response.dart';
import 'package:bac_project/features/notifications/domain/requests/subscribe_to_topic_request.dart';
import 'package:bac_project/features/notifications/domain/requests/unsubscribe_from_topic_request.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/features/notifications/data/handlers/firebase_messaging_handlers.dart';
import 'package:bac_project/features/notifications/data/settings/app_local_notifications_settings.dart';
import 'package:bac_project/features/notifications/data/settings/firebase_messaging_settings.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_database_datasource.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/entities/app_notification.dart';

abstract class NotificationsRemoteDatasource {
  Future<Unit> initializeLocalNotification();
  Future<Unit> initializeFirebaseNotification();
  Future<Unit> createNotificationsChannel(AndroidNotificationChannel channel);
  Future<Unit> displayFirebaseNotification(RemoteMessage message);
  Future<Unit> displayLocalNotification({required AppNotification notification, bool oneTimeNotification = true, NotificationDetails? details});
  Future<SubscribeToTopicResponse> subscribeToTopic(SubscribeToTopicRequest request);
  Future<UnsubscribeFromTopicResponse> unsubscribeToTopic(UnsubscribeFromTopicRequest request);
  Future<String> getDeviceToken();
  Future<Unit> deleteDeviceToken();
}

class NotificationsRemoteDatasourceImplements implements NotificationsRemoteDatasource {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final NotificationsDatabaseDatasource _supabaseDatasource;

  NotificationsRemoteDatasourceImplements({required NotificationsDatabaseDatasource supabaseDatasource}) : _supabaseDatasource = supabaseDatasource;

  @override
  Future<Unit> initializeLocalNotification() async {
    await _requestNotificationPermission();

    for (var channel in AppLocalNotificationsSettings.channels) {
      await createNotificationsChannel(channel);
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
      alert: AppRemoteNotificationsSettings.showAlert,
      badge: AppRemoteNotificationsSettings.showBadge,
      sound: AppRemoteNotificationsSettings.showSound,
    );

    final handlers = FirebaseMessagingHandlers();

    // Set up handlers
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(handlers.onData, onDone: handlers.onDone, onError: handlers.onError);
    FirebaseMessaging.instance.onTokenRefresh.listen(handlers.onTokenRefreshed);
    FirebaseMessaging.onMessageOpenedApp.listen(handlers.onNotificationOpened);

    // Handle initial notification (when app is opened from terminated state)
    await handlers.onInitialNotification();

    // Subscribe to topics
    for (var topic in AppRemoteNotificationsSettings.defaultTopicList) {
      await subscribeToTopic(SubscribeToTopicRequest(topic: topic));
    }

    debugPrint("Firebase token: ${await getDeviceToken()}");
    return unit;
  }

  @override
  Future<Unit> createNotificationsChannel(AndroidNotificationChannel channel) async {
    final androidImplementation = _localNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.createNotificationChannel(channel);
    return unit;
  }

  @override
  Future<Unit> displayLocalNotification({
    required AppNotification notification,
    bool oneTimeNotification = true,
    NotificationDetails? details,
  }) async {
    if (!notification.isValid()) return unit;

    await _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch % 2147483647, // Ensure it fits in int32
      notification.title,
      notification.body,
      details ?? AppLocalNotificationsSettings.defaultNotificationsDetails(),
    );

    return unit;
  }

  @override
  Future<Unit> displayFirebaseNotification(RemoteMessage message) async {
    final notification = AppNotification.fromRemoteMessage(message);

    if (notification.isValid()) {
      await _localNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch % 2147483647, // Ensure it fits in int32
        notification.title,
        notification.body,
        AppLocalNotificationsSettings.defaultNotificationsDetails(),
      );
    }

    return unit;
  }

  @override
  Future<SubscribeToTopicResponse> subscribeToTopic(SubscribeToTopicRequest request) async {
    await _firebaseMessaging.subscribeToTopic(request.topic);

    // Also track in database via datasource
    try {
      await _supabaseDatasource.subscribeToTopicInDatabase(request);
    } catch (e) {
      debugPrint('Failed to track topic subscription in database: $e');
    }

    return SubscribeToTopicResponse(unit);
  }

  @override
  Future<UnsubscribeFromTopicResponse> unsubscribeToTopic(UnsubscribeFromTopicRequest request) async {
    await _firebaseMessaging.unsubscribeFromTopic(request.topic);

    // Also remove from database
    try {
      await _supabaseDatasource.unsubscribeFromTopicInDatabase(request);
    } catch (e) {
      debugPrint('Failed to remove topic subscription from database: $e');
    }

    return UnsubscribeFromTopicResponse(unit);
  }

  @override
  Future<Unit> deleteDeviceToken() async {
    await _firebaseMessaging.deleteToken();
    return unit;
  }

  @override
  Future<String> getDeviceToken() async {
    final token = Platform.isIOS ? await _firebaseMessaging.getAPNSToken() : await _firebaseMessaging.getToken();

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

  // Supabase-specific DB functions moved to `NotificationsDatabaseDatasource`.
}
