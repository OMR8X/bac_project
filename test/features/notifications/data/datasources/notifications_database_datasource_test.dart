import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/notifications/data/datasources/notifications_database_datasource.dart';
import '../../../../helpers/integration/test_auth_helper.dart';
import '../../../../helpers/integration/test_api_manager.dart';
import '../../../../helpers/integration/test_credentials.dart';

void main() {
  late String token;
  late TestApiManager testApiManager;
  late NotificationsDatabaseDatasourceImplements dataSource;

  setUpAll(() async {
    token = await signInForTests(
      email: testStudents[0].email,
      password: testAccountPassword,
    );
    testApiManager = TestApiManager(token);
    dataSource = NotificationsDatabaseDatasourceImplements(apiManager: testApiManager);
  });

  group('registerDeviceToken', () {
    test('placeholder test', () async {
      // TODO: Implement registerDeviceToken tests.
    });
  });

  group('getNotifications', () {
    test('placeholder test', () async {
      // TODO: Implement getNotifications tests.
    });
  });

  group('markNotificationsAsRead', () {
    test('placeholder test', () async {
      // TODO: Implement markNotificationsAsRead tests.
    });
  });

  group('subscribeToTopicInDatabase', () {
    test('placeholder test', () async {
      // TODO: Implement subscribeToTopicInDatabase tests.
    });
  });

  group('unsubscribeFromTopicInDatabase', () {
    test('placeholder test', () async {
      // TODO: Implement unsubscribeFromTopicInDatabase tests.
    });
  });

  group('getUserSubscribedTopics', () {
    test('placeholder test', () async {
      // TODO: Implement getUserSubscribedTopics tests.
    });
  });

  group('getNotificationsTopics', () {
    test('placeholder test', () async {
      // TODO: Implement getNotificationsTopics tests.
    });
  });
}
