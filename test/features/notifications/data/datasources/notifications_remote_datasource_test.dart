import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/notifications/data/datasources/notifications_remote_datasource.dart';
import '../../../../helpers/integration/test_auth_helper.dart';
import '../../../../helpers/integration/test_api_manager.dart';
import '../../../../helpers/integration/test_credentials.dart';

import 'package:mockito/mockito.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockFlutterLocalNotificationsPlugin extends Mock implements FlutterLocalNotificationsPlugin {}

void main() {
  late String token;
  late TestApiManager testApiManager;
  late NotificationsRemoteDatasourceImplements dataSource;

  setUpAll(() async {
    token = await signInForTests(
      email: testStudents[0].email,
      password: testAccountPassword,
    );
    testApiManager = TestApiManager(token);

    dataSource = NotificationsRemoteDatasourceImplements(
      firebaseMessaging: MockFirebaseMessaging(),
      localNotificationsPlugin: MockFlutterLocalNotificationsPlugin(),
    );
  });

  group('initializeLocalNotification', () {
    test('placeholder test', () async {
      // TODO: Implement initializeLocalNotification tests.
    });
  });

  group('initializeFirebaseNotification', () {
    test('placeholder test', () async {
      // TODO: Implement initializeFirebaseNotification tests.
    });
  });

  group('displayNotification', () {
    test('placeholder test', () async {
      // TODO: Implement displayNotification tests.
    });
  });

  group('subscribeToTopic', () {
    test('placeholder test', () async {
      // TODO: Implement subscribeToTopic tests.
    });
  });

  group('unsubscribeToTopic', () {
    test('placeholder test', () async {
      // TODO: Implement unsubscribeToTopic tests.
    });
  });

  group('getDeviceToken', () {
    test('placeholder test', () async {
      // TODO: Implement getDeviceToken tests.
    });
  });

  group('deleteDeviceToken', () {
    test('placeholder test', () async {
      // TODO: Implement deleteDeviceToken tests.
    });
  });
}
