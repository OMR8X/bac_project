import 'package:bac_project/core/resources/errors/exceptions_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_database_datasource.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../../domain/requests/get_notifications_request.dart';
import '../../domain/requests/register_device_token_request.dart';
import '../../domain/requests/mark_notification_as_read_request.dart';
import '../../domain/requests/subscribe_to_topic_request.dart';
import '../../domain/requests/unsubscribe_from_topic_request.dart';
import '../responses/get_notifications_response.dart';
import '../responses/get_user_subscribed_topics_response.dart';

class NotificationsRepositoryImplements implements NotificationsRepository {
  final NotificationsRemoteDatasource _remoteDatasource;
  final NotificationsDatabaseDatasource _supabaseDatasource;

  NotificationsRepositoryImplements(this._remoteDatasource, this._supabaseDatasource);

  @override
  Future<Either<Failure, Unit>> initializeNotification() async {
    try {
      await _remoteDatasource.initializeLocalNotification();
      await _remoteDatasource.initializeFirebaseNotification();
      return right(unit);
    } on Exception catch (e) {
      return left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, Unit>> displayFirebaseNotification({
    required RemoteMessage message,
  }) async {
    try {
      await _remoteDatasource.displayFirebaseNotification(message);
      return right(unit);
    } on Exception catch (e) {
      return left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, Unit>> displayNotification({
    required AppNotification notification,
    bool oneTimeNotification = true,
    NotificationDetails? details,
  }) async {
    try {
      await _remoteDatasource.displayLocalNotification(
        notification: notification,
        oneTimeNotification: oneTimeNotification,
        details: details,
      );
      return right(unit);
    } on Exception catch (e) {
      return left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, GetNotificationsResponse>> getNotifications(
    GetNotificationsRequest request,
  ) async {
    try {
      final GetNotificationsResponse response = await _supabaseDatasource.getNotifications(request);
      return Right(response);
    } on Exception catch (e) {
      return left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, Unit>> subscribeToTopic(SubscribeToTopicRequest request) async {
    try {
      await _remoteDatasource.subscribeToTopic(request);
      await _supabaseDatasource.subscribeToTopicInDatabase(request);
      return Right(unit);
    } on Exception catch (e) {
      return left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDeviceToken() async {
    try {
      await _remoteDatasource.deleteDeviceToken();
      return right(unit);
    } on Exception catch (e) {
      return left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, Unit>> unsubscribeToTopic(UnsubscribeFromTopicRequest request) async {
    try {
      await _remoteDatasource.unsubscribeToTopic(request);
      await _supabaseDatasource.unsubscribeFromTopicInDatabase(request);
      return Right(unit);
    } on Exception catch (e) {
      return left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, String>> getDeviceToken() async {
    try {
      final response = await _remoteDatasource.getDeviceToken();
      return right(response);
    } on Exception catch (e) {
      return left(e.toFailure);
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
      await _supabaseDatasource.registerDeviceToken(request);
      return Right(unit);
    } on Exception catch (e) {
      return left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, Unit>> markNotificationAsRead(
    MarkNotificationAsReadRequest request,
  ) async {
    try {
      final response = await _supabaseDatasource.markNotificationAsRead(request);
      return Right(response);
    } on Exception catch (e) {
      return left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, GetUserSubscribedTopicsResponse>> getUserSubscribedTopics() async {
    try {
      final response = await _supabaseDatasource.getUserSubscribedTopics();
      return Right(response);
    } on Exception catch (e) {
      return left(e.toFailure);
    }
  }
}
