import 'package:equatable/equatable.dart';

class UserTopicSubscription extends Equatable {
  final String userId;
  final int topicId;

  const UserTopicSubscription({required this.userId, required this.topicId});

  factory UserTopicSubscription.empty() {
    return const UserTopicSubscription(userId: '', topicId: 0);
  }

  UserTopicSubscription copyWith({String? userId, int? topicId}) {
    return UserTopicSubscription(userId: userId ?? this.userId, topicId: topicId ?? this.topicId);
  }

  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'topic_id': topicId};
  }

  factory UserTopicSubscription.fromJson(Map<String, dynamic> json) {
    return UserTopicSubscription(
      userId: json['user_id'] as String,
      topicId: json['topic_id'] as int,
    );
  }

  @override
  List<Object> get props => [userId, topicId];
}
