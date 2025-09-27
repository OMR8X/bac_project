import 'package:bac_project/features/notifications/domain/entities/remote_notification.dart';
import 'package:bac_project/features/notifications/domain/enums/notification_priority.dart';

class AppNotificationModel extends AppNotification {
  AppNotificationModel({
    required super.id,
    required super.topicId,
    super.topicTitle,
    required super.title,
    required super.body,
    super.imageUrl,
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
      topicId: json['topic_id'],
      topicTitle: json['topic_title'],
      title: json['title'],
      body: json['body'],
      imageUrl: json['image_url'],
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
      'topic_id': topicId,
      'title': title,
      'body': body,
      'image_url': imageUrl,
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
