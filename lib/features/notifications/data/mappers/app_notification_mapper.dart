import 'package:neuro_app/features/notifications/data/models/app_notification_model.dart';
import 'package:neuro_app/features/notifications/domain/entities/app_notification.dart';

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
      readAt: readAt,
    );
  }
}
