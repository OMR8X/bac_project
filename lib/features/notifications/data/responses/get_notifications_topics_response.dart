import 'package:bac_project/features/notifications/data/models/notification_topic_model.dart';
import 'package:bac_project/features/notifications/domain/entities/notifications_topic.dart';

class GetNotificationsTopicsResponse {
  final List<NotificationsTopic> topics;

  GetNotificationsTopicsResponse({required this.topics});

  factory GetNotificationsTopicsResponse.fromJson(Map<String, dynamic> json) {
    return GetNotificationsTopicsResponse(
      topics:
          (json['topics'] as List<dynamic>?)
              ?.map((topic) => NotificationTopicModel.fromJson(topic as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
