import 'package:bac_project/features/notifications/domain/entities/notification.dart';
import 'package:bac_project/features/notifications/domain/enums/notification_priority.dart';

class NotificationModel extends Notification {
  const NotificationModel({
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
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      topicId: json['topic_id'] as int,
      topicTitle: json['topic_title'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrl: json['image_url'] as String?,
      payload: json['payload'] as Map<String, dynamic>?,
      priority: NotificationPriority.fromString(json['priority'] ?? 'normal'),
      createdAt: DateTime.parse(json['created_at']),
      expiresAt: json['expires_at'] != null ? DateTime.parse(json['expires_at']) : null,
    );
  }

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'topic_id': topicId,
      'topic_title': topicTitle,
      'title': title,
      'body': body,
      'image_url': imageUrl,
      'payload': payload,
      'priority': priority.value,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
    };
  }
}
