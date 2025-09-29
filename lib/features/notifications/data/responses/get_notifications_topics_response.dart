import 'package:bac_project/features/notifications/data/models/notification_topic_model.dart';
import 'package:bac_project/features/notifications/domain/entities/notifications_topic.dart';

class GetNotificationsTopicsResponse {
  final List<NotificationsTopic> topics;

  GetNotificationsTopicsResponse({required this.topics});

  factory GetNotificationsTopicsResponse.fromJson(List<dynamic> json) {
    return GetNotificationsTopicsResponse(
      topics:
          json
              .map((topic) => NotificationTopicModel.fromJson(topic as Map<String, dynamic>))
              .toList(),
    );
  }
}
