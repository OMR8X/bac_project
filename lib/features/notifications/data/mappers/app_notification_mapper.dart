import 'package:bac_project/features/notifications/data/models/app_notification_model.dart';
import 'package:bac_project/features/notifications/domain/entities/remote_notification.dart';

extension AppNotificationModelMapper on AppNotificationModel {
  AppNotification get toEntity {
    return AppNotification(
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
      status: status,
      isStarred: isStarred,
      readAt: readAt,
    );
  }
}

extension AppNotificationMapper on AppNotification {
  AppNotificationModel get toModel {
    return AppNotificationModel(
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
      status: status,
      isStarred: isStarred,
      readAt: readAt,
    );
  }
}
