import 'package:bac_project/features/notifications/data/models/notification_topic_model.dart';
import 'package:bac_project/features/notifications/domain/entities/notifications_topic.dart';

class GetUserSubscribedTopicsResponse {
  final List<NotificationsTopic> topics;

  GetUserSubscribedTopicsResponse({required this.topics});

  factory GetUserSubscribedTopicsResponse.fromJson(Map<String, dynamic> json) {
    return GetUserSubscribedTopicsResponse(
      topics:
          (json['data'] as List)
              .map((topic) => NotificationTopicModel.fromJson(topic as Map<String, dynamic>))
              .toList(),
    );
  }
}
