import 'package:bac_project/features/notifications/domain/entities/user_notification.dart';

class UserNotificationModel extends UserNotification {
  const UserNotificationModel({
    required super.id,
    required super.userId,
    required super.notificationId,
    super.deliveredAt,
    super.readAt,
    super.dismissedAt,
    super.actionPerformed,
  });

  factory UserNotificationModel.fromJson(Map<String, dynamic> json) {
    return UserNotificationModel(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      notificationId: json['notification_id'] as int,
      deliveredAt: json['delivered_at'] != null ? DateTime.parse(json['delivered_at']) : null,
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
      dismissedAt: json['dismissed_at'] != null ? DateTime.parse(json['dismissed_at']) : null,
      actionPerformed: json['action_performed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'user_id': userId,
      'notification_id': notificationId,
      'delivered_at': deliveredAt?.toIso8601String(),
      'read_at': readAt?.toIso8601String(),
      'dismissed_at': dismissedAt?.toIso8601String(),
      'action_performed': actionPerformed,
    };
  }
}
