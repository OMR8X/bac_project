import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:bac_project/features/notifications/domain/enums/notification_priority.dart';

class AppNotificationModel extends AppNotification {
  AppNotificationModel({
    required super.id,
    required super.typeId,
    required super.topicId,
    required super.title,
    required super.body,
    super.imageUrl,
    super.actionType,
    super.actionValue,
    super.payload,
    required super.priority,
    required super.createdAt,
    super.expiresAt,
    required super.status,
    required super.isStarred,
    super.readAt,
  });

  factory AppNotificationModel.fromDatabaseJson(Map json) {
    return AppNotificationModel(
      id: json['id'],
      typeId: json['type_id'],
      topicId: json['topic_id'],
      title: json['title'],
      body: json['body'],
      imageUrl: json['image_url'],
      actionType: json['action_type'],
      actionValue: json['action_value'],
      payload: json['payload'],
      priority: NotificationPriority.fromString(json['priority'] ?? 'normal'),
      createdAt: DateTime.parse(json['created_at']),
      expiresAt: json['expires_at'] != null ? DateTime.parse(json['expires_at']) : null,
      status: json['status'] ?? 'unread',
      isStarred: json['is_starred'] ?? false,
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
    );
  }

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'type_id': typeId,
      'topic_id': topicId,
      'title': title,
      'body': body,
      'image_url': imageUrl,
      'action_type': actionType,
      'action_value': actionValue,
      'payload': payload,
      'priority': priority.value,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toUserNotificationJson(String userId) {
    return {
      'notification_id': id,
      'user_id': userId,
      'status': status,
      'is_starred': isStarred,
      'read_at': readAt?.toIso8601String(),
    };
  }
}
