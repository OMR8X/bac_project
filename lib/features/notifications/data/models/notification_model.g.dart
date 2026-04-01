// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: (json['id'] as num).toInt(),
      topicId: (json['topic_id'] as num?)?.toInt(),
      topicTitle: json['topic_title'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrl: json['image_url'] as String?,
      payload: json['payload'] as Map<String, dynamic>?,
      priority: $enumDecode(_$NotificationPriorityEnumMap, json['priority']),
      createdAt: DateTime.parse(json['created_at'] as String),
      expiresAt:
          json['expires_at'] == null
              ? null
              : DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic_id': instance.topicId,
      'topic_title': instance.topicTitle,
      'title': instance.title,
      'body': instance.body,
      'image_url': instance.imageUrl,
      'payload': instance.payload,
      'priority': _$NotificationPriorityEnumMap[instance.priority]!,
      'created_at': instance.createdAt.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
    };

const _$NotificationPriorityEnumMap = {
  NotificationPriority.low: 'low',
  NotificationPriority.normal: 'normal',
  NotificationPriority.high: 'high',
};
