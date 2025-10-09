// ignore_for_file: unnecessary_null_comparison

import 'package:bac_project/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:bac_project/features/notifications/domain/enums/notification_priority.dart';
import 'package:bac_project/features/notifications/domain/requests/subscribe_to_topic_request.dart';
import 'package:bac_project/features/notifications/domain/requests/unsubscribe_from_topic_request.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NotificationsRemoteDatasourceImplements dataSource;

  setUp(() {
    final firebaseMessaging = FirebaseMessaging.instance;
    final localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    dataSource = NotificationsRemoteDatasourceImplements(
      firebaseMessaging: firebaseMessaging,
      localNotificationsPlugin: localNotificationsPlugin,
    );
  });

  group('NotificationsRemoteDatasourceImplements', () {
    group('initializeLocalNotification', () {
      test('should return unit when local notification is initialized successfully', () async {
        // Act & Assert - Method should return expected type
        final result = await dataSource.initializeLocalNotification();
        expect(result, isA<Unit>());
      });
    });

    group('initializeFirebaseNotification', () {
      test('should return unit when firebase notification is initialized successfully', () async {
        // Act & Assert - Method should return expected type
        final result = await dataSource.initializeFirebaseNotification();
        expect(result, isA<Unit>());
      });
    });

    group('displayNotification', () {
      test('should return unit when notification is displayed successfully', () async {
        // Arrange
        final notification = AppNotification(
          id: 1,
          topicId: 1,
          title: 'Test Title',
          body: 'Test Body',
          priority: NotificationPriority.normal,
          createdAt: DateTime.now(),
        );

        // Act & Assert - Method should return expected type
        final result = await dataSource.displayNotification(notification: notification);
        expect(result, isA<Unit>());
      });
    });

    group('subscribeToTopic', () {
      test('should return unit when topic subscription is successful', () async {
        // Arrange
        final request = SubscribeToTopicRequest(topicId: 1, firebaseTopicName: 'test-topic');

        // Act & Assert - Method should return expected type
        final result = await dataSource.subscribeToTopic(request);
        expect(result, isA<Unit>());
      });
    });

    group('unsubscribeToTopic', () {
      test('should return unit when topic unsubscription is successful', () async {
        // Arrange
        final request = UnsubscribeFromTopicRequest(topicId: 1, firebaseTopicName: 'test-topic');

        // Act & Assert - Method should return expected type
        final result = await dataSource.unsubscribeToTopic(request);
        expect(result, isA<Unit>());
      });
    });

    group('getDeviceToken', () {
      test('should return device token when token is available', () async {
        // Act & Assert - Method should return expected type
        final result = await dataSource.getDeviceToken();
        expect(result, isA<String>());
      });
    });

    group('deleteDeviceToken', () {
      test('should return unit when device token is deleted successfully', () async {
        // Act & Assert - Method should return expected type
        final result = await dataSource.deleteDeviceToken();
        expect(result, isA<Unit>());
      });
    });
  });
}
