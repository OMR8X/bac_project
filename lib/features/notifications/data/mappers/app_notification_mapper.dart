import 'package:bac_project/features/notifications/data/models/app_notification_model.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';

extension AppNotificationModelMapper on AppNotificationModel {
  AppNotification get toEntity {
    return AppNotification(
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
      status: status,
      isStarred: isStarred,
      readAt: readAt,
    );
  }
}
