import 'package:bac_project/features/notifications/data/models/notification_model.dart';
import 'package:bac_project/features/notifications/data/models/notification_topic_model.dart';
import 'package:bac_project/features/notifications/data/models/notification_type_model.dart';
import 'package:bac_project/features/notifications/data/models/user_notification_model.dart';
import 'package:bac_project/features/notifications/data/models/user_topic_subscription_model.dart';
import 'package:bac_project/features/notifications/domain/entities/notification.dart';
import 'package:bac_project/features/notifications/domain/entities/notifications_topic.dart';
import 'package:bac_project/features/notifications/domain/entities/notification_type.dart';
import 'package:bac_project/features/notifications/domain/entities/user_notification.dart';
import 'package:bac_project/features/notifications/domain/entities/user_topic_subscription.dart';

// Notification Mappers
extension NotificationModelMapper on NotificationModel {
  Notification get toEntity => Notification(
    id: id,
    typeId: typeId,
    topicId: topicId,
    title: title,
    body: body,
    imageUrl: imageUrl,
    actionType: actionType,
    actionValue: actionValue,
    payload: payload,
    priority: priority,
    createdAt: createdAt,
    expiresAt: expiresAt,
  );
}

extension NotificationMapper on Notification {
  NotificationModel get toModel => NotificationModel(
    id: id,
    typeId: typeId,
    topicId: topicId,
    title: title,
    body: body,
    imageUrl: imageUrl,
    actionType: actionType,
    actionValue: actionValue,
    payload: payload,
    priority: priority,
    createdAt: createdAt,
    expiresAt: expiresAt,
  );
}

// NotificationTopic Mappers
extension NotificationTopicModelMapper on NotificationTopicModel {
  NotificationsTopic get toEntity =>
      NotificationsTopic(id: id, name: name, description: description);
}

extension NotificationTopicMapper on NotificationsTopic {
  NotificationTopicModel get toModel =>
      NotificationTopicModel(id: id, name: name, description: description);
}

// NotificationType Mappers
extension NotificationTypeModelMapper on NotificationTypeModel {
  NotificationType get toEntity => NotificationType(id: id, name: name, description: description);
}

extension NotificationTypeMapper on NotificationType {
  NotificationTypeModel get toModel =>
      NotificationTypeModel(id: id, name: name, description: description);
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
