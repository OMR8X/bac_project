// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_topic_subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTopicSubscriptionModel _$UserTopicSubscriptionModelFromJson(
  Map<String, dynamic> json,
) => UserTopicSubscriptionModel(
  userId: json['user_id'] as String,
  topicId: (json['topic_id'] as num).toInt(),
);

Map<String, dynamic> _$UserTopicSubscriptionModelToJson(
  UserTopicSubscriptionModel instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'topic_id': instance.topicId,
};
