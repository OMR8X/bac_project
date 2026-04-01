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
  createdAt: DateTime.parse(json['created_at'] as String),
  readAt:
      json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String),
);

Map<String, dynamic> _$UserNotificationModelToJson(
  UserNotificationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'notification_id': instance.notificationId,
  'created_at': instance.createdAt.toIso8601String(),
  'read_at': instance.readAt?.toIso8601String(),
};
