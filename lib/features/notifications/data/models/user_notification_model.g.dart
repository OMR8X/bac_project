// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotificationModel _$UserNotificationModelFromJson(
  Map<String, dynamic> json,
) => UserNotificationModel(
  id: (json['id'] as num).toInt(),
  userId: json['user_id'] as String,
  notificationId: (json['notification_id'] as num).toInt(),
  deliveredAt:
      json['delivered_at'] == null
          ? null
          : DateTime.parse(json['delivered_at'] as String),
  readAt:
      json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String),
  dismissedAt:
      json['dismissed_at'] == null
          ? null
          : DateTime.parse(json['dismissed_at'] as String),
  actionPerformed: json['action_performed'] as bool? ?? false,
);

Map<String, dynamic> _$UserNotificationModelToJson(
  UserNotificationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'notification_id': instance.notificationId,
  'delivered_at': instance.deliveredAt?.toIso8601String(),
  'read_at': instance.readAt?.toIso8601String(),
  'dismissed_at': instance.dismissedAt?.toIso8601String(),
  'action_performed': instance.actionPerformed,
};
