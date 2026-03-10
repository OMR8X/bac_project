import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/notifications/domain/entities/user_topic_subscription.dart';

part 'user_topic_subscription_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserTopicSubscriptionModel extends UserTopicSubscription {
  const UserTopicSubscriptionModel({
    required super.userId,
    required super.topicId,
  });

  factory UserTopicSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$UserTopicSubscriptionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserTopicSubscriptionModelToJson(this);

  Map<String, dynamic> toDatabaseJson() => _$UserTopicSubscriptionModelToJson(this);
}
