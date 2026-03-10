// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationTopicModel _$NotificationTopicModelFromJson(
  Map<String, dynamic> json,
) => NotificationTopicModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  firebaseTopic: json['firebase_topic'] as String,
  subscribable: json['subscribable'] as bool? ?? true,
);

Map<String, dynamic> _$NotificationTopicModelToJson(
  NotificationTopicModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'firebase_topic': instance.firebaseTopic,
  'subscribable': instance.subscribable,
};
