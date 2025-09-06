import 'package:bac_project/features/notifications/data/models/app_notification_model.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';

extension AppNotificationModelMapper on AppNotificationModel {
  AppNotification get toEntity {
    return AppNotification(
      id: id,
      title: title,
      body: body,
      html: html,
      imageUrl: imageUrl,
      type: type,
      status: status,
      isStarred: isStarred,
      readAt: readAt,
      fcmMessageId: fcmMessageId,
      date: date,
      data: data,
    );
  }
}

extension AppNotificationMapper on AppNotification {
  AppNotificationModel get toModel {
    return AppNotificationModel(
      id: id,
      title: title,
      body: body,
      html: html,
      imageUrl: imageUrl,
      type: type,
      status: status,
      isStarred: isStarred,
      readAt: readAt,
      fcmMessageId: fcmMessageId,
      date: date,
      data: data,
    );
  }
}
