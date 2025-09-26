import 'package:bac_project/features/notifications/domain/entities/notification.dart';
import 'package:bac_project/features/notifications/domain/enums/notification_priority.dart';

class NotificationModel extends Notification {
  const NotificationModel({
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
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      typeId: json['type_id'] as int,
      topicId: json['topic_id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrl: json['image_url'] as String?,
      actionType: json['action_type'] as String?,
      actionValue: json['action_value'] as String?,
      payload: json['payload'] as Map<String, dynamic>?,
      priority: NotificationPriority.fromString(json['priority'] ?? 'normal'),
      createdAt: DateTime.parse(json['created_at']),
      expiresAt: json['expires_at'] != null ? DateTime.parse(json['expires_at']) : null,
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
}
