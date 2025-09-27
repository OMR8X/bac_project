import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/errors/error_mapper.dart';
import 'package:bac_project/core/services/logs/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_database_datasource.dart';
import 'package:bac_project/features/notifications/domain/entities/remote_notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../../domain/requests/get_notifications_request.dart';
import '../../domain/requests/register_device_token_request.dart';
import '../../domain/requests/mark_notifications_as_read_request.dart';
import '../../domain/requests/subscribe_to_topic_request.dart';
import '../../domain/requests/unsubscribe_from_topic_request.dart';
import '../responses/get_notifications_response.dart';
import '../responses/get_notifications_topics_response.dart';
import '../responses/get_user_subscribed_topics_response.dart';

class NotificationsRepositoryImplements implements NotificationsRepository {
  final NotificationsRemoteDatasource _remoteDatasource;
  final NotificationsDatabaseDatasource _databaseDatasource;
  final Logger _logger = sl<Logger>();

  NotificationsRepositoryImplements(this._remoteDatasource, this._databaseDatasource);

  @override
  Future<Either<Failure, Unit>> initializeNotification() async {
    try {
      await _remoteDatasource.initializeLocalNotification();
      await _remoteDatasource.initializeFirebaseNotification();
      return right(unit);
    } on Exception catch (e) {
      return left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> displayNotification({
    required AppNotification notification,
    bool oneTimeNotification = true,
    NotificationDetails? details,
  }) async {
    try {
      await _remoteDatasource.displayNotification(
        notification: notification,
        oneTimeNotification: oneTimeNotification,
        details: details,
      );
      return right(unit);
    } on Exception catch (e) {
      return left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetNotificationsResponse>> getNotifications(
    GetNotificationsRequest request,
  ) async {
    try {
      final response = await _databaseDatasource.getNotifications(request);
      return Right(response);
    } on Exception catch (e) {
        return left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> subscribeToTopic(SubscribeToTopicRequest request) async {
    try {
      await _remoteDatasource.subscribeToTopic(request);
      await _databaseDatasource.subscribeToTopicInDatabase(request);
      return Right(unit);
    } on Exception catch (e) {
      return left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDeviceToken() async {
    try {
      await _remoteDatasource.deleteDeviceToken();
      return right(unit);
    } on Exception catch (e) {
      return left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> unsubscribeToTopic(UnsubscribeFromTopicRequest request) async {
    try {
      await _remoteDatasource.unsubscribeToTopic(request);
      await _databaseDatasource.unsubscribeFromTopicInDatabase(request);
      return Right(unit);
    } on Exception catch (e) {
      return left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> getDeviceToken() async {
    try {
      final response = await _remoteDatasource.getDeviceToken();
      return right(response);
    } on Exception catch (e) {
      return left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> refreshDeviceToken() async {
    await FirebaseMessaging.instance.deleteToken();
    return getDeviceToken();
  }

  @override
  Future<Either<Failure, Unit>> registerDeviceToken(RegisterDeviceTokenRequest request) async {
    try {
      await _databaseDatasource.registerDeviceToken(request);
      return Right(unit);
    } on Exception catch (e) {
      return left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> markNotificationsAsRead(
    MarkNotificationsAsReadRequest request,
  ) async {
    try {
      final response = await _databaseDatasource.markNotificationsAsRead(request);
      return Right(response);
    } on Exception catch (e) {
        return left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetUserSubscribedTopicsResponse>> getUserSubscribedTopics() async {
    try {
      final response = await _databaseDatasource.getUserSubscribedTopics();
      return Right(response);
    } on Exception catch (e) {
      return left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetNotificationsTopicsResponse>> getNotificationsTopics() async {
    try {
      final response = await _databaseDatasource.getNotificationsTopics();
      return Right(response);
    } on Exception catch (e) {
      return left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> syncNotifications() async {
    try {
      // First, get device token and register it in database
      final deviceTokenResult = await getDeviceToken();
      final deviceToken = deviceTokenResult.getOrElse(
        () => throw Exception('Failed to get device token'),
      );

      final registerTokenRequest = await RegisterDeviceTokenRequest.fromDeviceToken(deviceToken);
      final registerResult = await registerDeviceToken(registerTokenRequest);
      registerResult.getOrElse(() => throw Exception('Failed to register device token'));
      _logger.logMessage('✅ Device token sync successfully.');

      // Then, get user subscribed topics and subscribe to them locally
      final subscribedTopicsResult = await getUserSubscribedTopics();
      final subscribedTopicsResponse = subscribedTopicsResult.getOrElse(
        () => throw Exception('Failed to get subscribed topics'),
      );

      // Subscribe to each topic locally (remote datasource)
      for (final topic in subscribedTopicsResponse.topics) {
        final subscribeRequest = SubscribeToTopicRequest(
          topicId: topic.id,
          firebaseTopicName: topic.firebaseTopic,
        );
        await _remoteDatasource.subscribeToTopic(subscribeRequest);
      }

      _logger.logMessage('✅ Topics synced successfully.');
      return right(unit);
    } on Exception catch (e) {
      _logger.logError(
        'Notifications sync failed: ${e.toString()}',
        stackTrace: StackTrace.current,
      );
      return left(errorToFailure(e));
    }
  }
}
