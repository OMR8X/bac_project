import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_local_datasource.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:bac_project/features/notifications/data/responses/send_notification_response.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImplements implements NotificationsRepository {
  final NotificationsRemoteDatasource _remoteDatasource;
  final NotificationsLocalDatasource _localDatasource;

  NotificationsRepositoryImplements(this._localDatasource, this._remoteDatasource);
  @override
  Future<Either<Failure, Unit>> initializeLocalNotification() async {
    try {
      final response = await _remoteDatasource.initializeLocalNotification();
      return right(response);
    } on Exception catch (e) {
      return left(AnonFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> initializeFirebaseNotification() async {
    try {
      final response = await _remoteDatasource.initializeFirebaseNotification();
      return right(response);
    } on Exception catch (e) {
      return left(AnonFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelNotification({required int id}) async {
    try {
      final response = await _remoteDatasource.cancelNotification(id);
      return right(response);
    } on Exception catch (e) {
      return left(AnonFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> createNotificationsChannel({
    required AndroidNotificationChannel channel,
  }) async {
    try {
      final response = await _remoteDatasource.createNotificationsChannel(channel);
      return right(unit);
    } on Exception catch (e) {
      return left(AnonFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> displayFirebaseNotification({
    required RemoteMessage message,
  }) async {
    try {
      final response = await _remoteDatasource.displayFirebaseNotification(message);
      final res2 = await _localDatasource.insertNotification(
        notification: AppNotification.fromRemoteMessage(message),
      );
      debugPrint("debugging num $res2");
      return right(response);
    } on Exception catch (e) {
      debugPrint("debugging error ${e.toString()}");
      return left(AnonFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> displayNotification({
    required AppNotification notification,
    bool oneTimeNotification = true,
    NotificationDetails? details,
  }) async {
    try {
      final response = await _remoteDatasource.displayNotification(
        notification: notification,
        oneTimeNotification: oneTimeNotification,
        details: details,
      );
      await _localDatasource.insertNotification(notification: notification);
      return right(response);
    } on Exception catch (e) {
      return left(AnonFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppNotification>>> getNotifications() async {
    try {
      final response = await _localDatasource.getNotifications();
      return right(response);
    } on Exception catch (e) {
      return left(AnonFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearNotifications() async {
    try {
      final response = await _localDatasource.clearNotifications();
      return right(response);
    } on Exception catch (e) {
      return left(AnonFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNotification({required int notificationId}) async {
    try {
      final response = await _localDatasource.deleteNotification(notificationId: notificationId);
      return right(unit);
    } on Exception catch (e) {
      return left(AnonFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> subscribeToTopic({required String topic}) async {
    try {
      await _remoteDatasource.subscribeToTopic(topic);
      return right(unit);
    } on Exception catch (e) {
      return left(AnonFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDeviceToken() async {
    try {
      await _remoteDatasource.deleteDeviceToken();
      return right(unit);
    } on Exception catch (e) {
      return left(AnonFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> unsubscribeToTopic({required String topic}) async {
    try {
      await _remoteDatasource.unsubscribeToTopic(topic);
      return right(unit);
    } on Exception catch (e) {
      return left(AnonFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getDeviceToken() async {
    try {
      final response = await _remoteDatasource.getDeviceToken();
      return right(response);
    } on Exception catch (e) {
      return left(AnonFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> refreshDeviceToken() async {
    await FirebaseMessaging.instance.deleteToken();
    return getDeviceToken();
  }
}
