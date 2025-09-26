import 'package:bac_project/features/notifications/domain/entities/user_topic_subscription.dart';

class UserTopicSubscriptionModel extends UserTopicSubscription {
  const UserTopicSubscriptionModel({required super.userId, required super.topicId});

  factory UserTopicSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return UserTopicSubscriptionModel(
      userId: json['user_id'] as String,
      topicId: json['topic_id'] as int,
    );
  }

  Map<String, dynamic> toDatabaseJson() {
    return {'user_id': userId, 'topic_id': topicId};
  }
}
