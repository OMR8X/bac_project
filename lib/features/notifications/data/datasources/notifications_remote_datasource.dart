import 'dart:io';

import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/entities/app_notification.dart';
import '../handlers/firebase_messaging_handlers.dart';
import '../settings/app_local_notifications_settings.dart';
import '../settings/firebase_messaging_settings.dart';

abstract class NotificationsRemoteDatasource {
  Future<Unit> initializeLocalNotification();
  Future<Unit> initializeFirebaseNotification();
  Future<Unit> cancelNotification(int id);
  Future<Unit> createNotificationsChannel(AndroidNotificationChannel channel);
  Future<Unit> displayFirebaseNotification(RemoteMessage message);
  Future<Unit> displayNotification({
    required AppNotification notification,
    bool oneTimeNotification = true,
    NotificationDetails? details,
  });
  Future<Unit> subscribeToTopic(String topic);
  Future<Unit> unsubscribeToTopic(String topic);
  Future<String?> getDeviceToken();
  Future<Unit> deleteDeviceToken();
}

class NotificationsRemoteDatasourceImplements implements NotificationsRemoteDatasource {
  final ApiManager _apiManager;

  NotificationsRemoteDatasourceImplements(this._apiManager);
  @override
  Future<Unit> displayNotification({
    required AppNotification notification,
    bool oneTimeNotification = true,
    NotificationDetails? details,
  }) async {
    /// handle state where notification is not valid
    if (!notification.valid()) return unit;

    ///
    await FlutterLocalNotificationsPlugin().show(
      notification.id,
      notification.title,
      notification.subtitle,
      details ?? AppLocalNotificationsSettings.defaultNotificationsDetails(),
    );

    return unit;
  }

  @override
  Future<Unit> displayFirebaseNotification(RemoteMessage message) async {
    ///
    AppNotification notification = AppNotification.fromRemoteMessage(message);
    debugPrint(notification.toString());

    /// handle state where firebase will automatically display notification
    if (message.notification?.title != null) {
      debugPrint("firebase notification title is ${message.notification?.title}");
      return unit;
    }

    /// handle state where notification is not valid
    if (!notification.valid()) {
      debugPrint("firebase notification is not valid");
      return unit;
    }

    ///
    await FlutterLocalNotificationsPlugin().show(
      DateTime.now().millisecond,
      notification.title,
      notification.subtitle,
      AppLocalNotificationsSettings.remoteNotificationsDetails(
        imagePath: await downloadAndSaveImage(notification.imageUrl),
      ),
    );

    ///
    return unit;
  }

  @override
  Future<Unit> createNotificationsChannel(AndroidNotificationChannel channel) async {
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    return unit;
  }

  @override
  Future<Unit> initializeFirebaseNotification() async {
    ///
    final instance = FirebaseMessaging.instance;
    final settings = await instance.requestPermission();

    ///
    await instance.setForegroundNotificationPresentationOptions(
      alert: AppRemoteNotificationsSettings.showAlert,
      badge: AppRemoteNotificationsSettings.showBadge,
      sound: AppRemoteNotificationsSettings.showSound,
    );

    ///
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    ///
    FirebaseMessaging.onMessage.listen(onData, onDone: onDone, onError: onError);

    ///
    FirebaseMessaging.instance.onTokenRefresh.listen(onTokenRefreshed);

    ///
    for (var topic in AppRemoteNotificationsSettings.defaultTopicList) {
      await subscribeToTopic(topic);
    }

    ///
    debugPrint("debugging firebase token ${await getDeviceToken()}");

    ///
    return unit;
  }

  @override
  Future<Unit> initializeLocalNotification() async {
    ///
    const settings = AppLocalNotificationsSettings.settings;

    ///
    await _requestNotificationPermission();

    ///
    for (var channel in AppLocalNotificationsSettings.channels) {
      await createNotificationsChannel(channel);
    }

    ///
    await FlutterLocalNotificationsPlugin().initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse? notificationResponse) {
        if (notificationResponse == null) {
          return;
        }

        return;
      },
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );

    ///
    return unit;
  }

  @override
  Future<Unit> cancelNotification(int id) async {
    await FlutterLocalNotificationsPlugin().cancel(id);
    return unit;
  }

  @override
  Future<Unit> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    return unit;
  }

  @override
  Future<Unit> unsubscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    return unit;
  }

  @override
  Future<Unit> deleteDeviceToken() async {
    await FirebaseMessaging.instance.deleteToken();
    return unit;
  }

  @override
  Future<String?> getDeviceToken() async {
    String? token;
    if (Platform.isIOS) {
      token = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }
    //
    return token;
  }

  Future<void> _requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied) {
      status = await Permission.notification.request();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Future<String?> downloadAndSaveImage(String? url) async {
    try {
      if (url == null || url.isEmpty) return null;
      final fileName = DateTime.now().millisecondsSinceEpoch;
      final fileExtension = url.split('.').last;
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$fileName.$fileExtension';

      final response = await Dio().download(url, filePath);
      if (response.statusCode == 200) {
        return filePath;
      } else {
        return null;
      }
    } on Exception {
      return null;
    }
  }
}
