import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:bac_project/features/notifications/domain/requests/get_notifications_request.dart';
import 'package:bac_project/features/notifications/domain/requests/register_device_token_request.dart';
import 'package:bac_project/features/notifications/domain/requests/update_notification_status_request.dart';
import 'package:bac_project/features/notifications/domain/requests/toggle_notification_star_request.dart';
import 'package:bac_project/features/notifications/domain/requests/subscribe_to_topic_request.dart';
import 'package:bac_project/features/notifications/domain/requests/unsubscribe_from_topic_request.dart';
import 'package:bac_project/features/notifications/domain/requests/get_user_subscribed_topics_request.dart';
import 'package:bac_project/features/notifications/data/responses/get_notifications_response.dart';
import 'package:bac_project/features/notifications/data/responses/register_device_token_response.dart';
import 'package:bac_project/features/notifications/data/responses/update_notification_status_response.dart';
import 'package:bac_project/features/notifications/data/responses/toggle_notification_star_response.dart';
import 'package:bac_project/features/notifications/data/responses/subscribe_to_topic_response.dart';
import 'package:bac_project/features/notifications/data/responses/unsubscribe_from_topic_response.dart';
import 'package:bac_project/features/notifications/data/responses/get_user_subscribed_topics_response.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, Unit>> initializeLocalNotification();

  Future<Either<Failure, Unit>> initializeFirebaseNotification();

  Future<Either<Failure, GetNotificationsResponse>> getNotifications(GetNotificationsRequest request);

  Future<Either<Failure, Unit>> displayNotification({
    required AppNotification notification,
    bool oneTimeNotification = false,
    NotificationDetails? details,
  });

  Future<Either<Failure, Unit>> displayFirebaseNotification({required RemoteMessage message});

  Future<Either<Failure, Unit>> createNotificationsChannel({required AndroidNotificationChannel channel});

  Future<Either<Failure, SubscribeToTopicResponse>> subscribeToTopic(SubscribeToTopicRequest request);

  Future<Either<Failure, UnsubscribeFromTopicResponse>> unsubscribeToTopic(UnsubscribeFromTopicRequest request);

  Future<Either<Failure, String>> getDeviceToken();

  Future<Either<Failure, String>> refreshDeviceToken();

  Future<Either<Failure, Unit>> deleteDeviceToken();

  Future<Either<Failure, RegisterDeviceTokenResponse>> registerDeviceToken(RegisterDeviceTokenRequest request);

  // New status management methods
  Future<Either<Failure, UpdateNotificationStatusResponse>> markNotificationAsRead(UpdateNotificationStatusRequest request);

  Future<Either<Failure, UpdateNotificationStatusResponse>> markNotificationAsUnread(UpdateNotificationStatusRequest request);

  Future<Either<Failure, UpdateNotificationStatusResponse>> deleteNotification(UpdateNotificationStatusRequest request);

  Future<Either<Failure, ToggleNotificationStarResponse>> toggleNotificationStar(ToggleNotificationStarRequest request);

  // Topic subscription tracking
  Future<Either<Failure, GetUserSubscribedTopicsResponse>> getUserSubscribedTopics(GetUserSubscribedTopicsRequest request);

  // Backward compatibility
  @Deprecated('Use markNotificationAsRead instead')
  Future<Either<Failure, UpdateNotificationStatusResponse>> markNotificationAsSeen(UpdateNotificationStatusRequest request);
}
