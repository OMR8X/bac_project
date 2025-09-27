import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bac_project/features/notifications/domain/entities/remote_notification.dart';
import 'package:bac_project/features/notifications/domain/requests/get_notifications_request.dart';
import 'package:bac_project/features/notifications/domain/requests/register_device_token_request.dart';
import 'package:bac_project/features/notifications/domain/requests/mark_notifications_as_read_request.dart';
import 'package:bac_project/features/notifications/domain/requests/subscribe_to_topic_request.dart';
import 'package:bac_project/features/notifications/domain/requests/unsubscribe_from_topic_request.dart';
import 'package:bac_project/features/notifications/data/responses/get_notifications_response.dart';
import 'package:bac_project/features/notifications/data/responses/get_notifications_topics_response.dart';
import 'package:bac_project/features/notifications/data/responses/get_user_subscribed_topics_response.dart';

abstract class NotificationsRepository {
  /// [ INITIALIZATION ]
  Future<Either<Failure, Unit>> initializeNotification();

  /// [ QUERIES ]
  Future<Either<Failure, GetNotificationsResponse>> getNotifications(
    GetNotificationsRequest request,
  );

  /// [ DISPLAYING ]
  Future<Either<Failure, Unit>> displayNotification({
    required AppNotification notification,
    NotificationDetails? details,
    bool oneTimeNotification = false,
  });

  /// [ TOKENS ]
  Future<Either<Failure, String>> getDeviceToken();

  Future<Either<Failure, String>> refreshDeviceToken();

  Future<Either<Failure, Unit>> deleteDeviceToken();

  Future<Either<Failure, Unit>> registerDeviceToken(RegisterDeviceTokenRequest request);

  /// [ STATUS ]
  Future<Either<Failure, Unit>> markNotificationsAsRead(MarkNotificationsAsReadRequest request);

  /// [ TOPICS ]
  Future<Either<Failure, GetUserSubscribedTopicsResponse>> getUserSubscribedTopics();
  Future<Either<Failure, GetNotificationsTopicsResponse>> getNotificationsTopics();
  Future<Either<Failure, Unit>> subscribeToTopic(SubscribeToTopicRequest request);

  Future<Either<Failure, Unit>> unsubscribeToTopic(UnsubscribeFromTopicRequest request);

  /// [ SYNCHRONIZATION ]
  Future<Either<Failure, Unit>> syncNotifications();
}
