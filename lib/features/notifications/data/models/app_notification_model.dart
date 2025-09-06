import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';

class AppNotificationModel extends AppNotification {
  AppNotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.html,
    required super.type,
    required super.status,
    required super.isStarred,
    required super.readAt,
    required super.fcmMessageId,
    required super.date,
    super.imageUrl,
    super.data,
  });

  factory AppNotificationModel.fromDatabaseJson(Map json) {
    return AppNotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      html: json['html'],
      imageUrl: json['image_url'],
      type: json['type'] ?? 'direct',
      status: json['status'] ?? 'unread',
      isStarred: json['is_starred'] ?? false,
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
      fcmMessageId: json['fcm_message_id'],
      date: DateTime.parse(json['created_at']),
      data: json['data'] is Map ? Map<String, dynamic>.from(json['data']) : null,
    );
  }

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'html': html,
      'image_url': imageUrl,
      'type': type,
      'fcm_message_id': fcmMessageId,
      'created_at': date.toIso8601String(),
      'data': data,
    };
  }

  Map<String, dynamic> toUserNotificationJson(String userId) {
    return {'notification_id': id, 'user_id': userId, 'status': status, 'is_starred': isStarred, 'read_at': readAt?.toIso8601String()};
  }
}
