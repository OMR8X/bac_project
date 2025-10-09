import 'package:bac_project/features/notifications/data/models/notification_action_model.dart';
import 'package:bac_project/features/notifications/data/models/notification_model.dart';
import 'package:bac_project/features/notifications/data/models/notification_topic_model.dart';
import 'package:bac_project/features/notifications/data/models/user_notification_model.dart';
import 'package:bac_project/features/notifications/data/models/user_topic_subscription_model.dart';
import 'package:bac_project/features/notifications/domain/entities/notification.dart';
import 'package:bac_project/features/notifications/domain/entities/notification_action.dart';
import 'package:bac_project/features/notifications/domain/entities/notifications_topic.dart';
import 'package:bac_project/features/notifications/domain/entities/user_notification.dart';
import 'package:bac_project/features/notifications/domain/entities/user_topic_subscription.dart';

// Notification Mappers
extension NotificationModelMapper on NotificationModel {
  Notification get toEntity => Notification(
    id: id,
    topicId: topicId,
    topicTitle: topicTitle,
    title: title,
    body: body,
    imageUrl: imageUrl,
    payload: payload,
    priority: priority,
    createdAt: createdAt,
    expiresAt: expiresAt,
  );
}

extension NotificationMapper on Notification {
  NotificationModel get toModel => NotificationModel(
    id: id,
    topicId: topicId,
    topicTitle: topicTitle,
    title: title,
    body: body,
    imageUrl: imageUrl,
    payload: payload,
    priority: priority,
    createdAt: createdAt,
    expiresAt: expiresAt,
  );
}

// NotificationTopic Mappers
extension NotificationTopicModelMapper on NotificationTopicModel {
  NotificationsTopic get toEntity => NotificationsTopic(
    id: id,
    title: title,
    description: description,
    firebaseTopic: firebaseTopic,
    subscribable: subscribable,
  );
}

extension NotificationTopicMapper on NotificationsTopic {
  NotificationTopicModel get toModel => NotificationTopicModel(
    id: id,
    title: title,
    description: description,
    firebaseTopic: firebaseTopic,
    subscribable: subscribable,
  );
}

// UserNotification Mappers
extension UserNotificationModelMapper on UserNotificationModel {
  UserNotification get toEntity => UserNotification(
    id: id,
    userId: userId,
    notificationId: notificationId,
    deliveredAt: deliveredAt,
    readAt: readAt,
    dismissedAt: dismissedAt,
    actionPerformed: actionPerformed,
  );
}

extension UserNotificationMapper on UserNotification {
  UserNotificationModel get toModel => UserNotificationModel(
    id: id,
    userId: userId,
    notificationId: notificationId,
    deliveredAt: deliveredAt,
    readAt: readAt,
    dismissedAt: dismissedAt,
    actionPerformed: actionPerformed,
  );
}

// UserTopicSubscription Mappers
extension UserTopicSubscriptionModelMapper on UserTopicSubscriptionModel {
  UserTopicSubscription get toEntity => UserTopicSubscription(userId: userId, topicId: topicId);
}

extension UserTopicSubscriptionMapper on UserTopicSubscription {
  UserTopicSubscriptionModel get toModel =>
      UserTopicSubscriptionModel(userId: userId, topicId: topicId);
}

// NotificationAction Mappers
extension NotificationActionModelMapper on NotificationActionModel {
  NotificationAction get toEntity => NotificationAction(
    label: label,
    type: type,
    uri: uri,
  );
}

extension NotificationActionMapper on NotificationAction {
  NotificationActionModel get toModel => NotificationActionModel(
    label: label,
    type: type,
    uri: uri,
  );
}
