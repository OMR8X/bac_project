import 'package:bac_project/features/notifications/domain/entities/notifications_topic.dart';

class GetUserSubscribedTopicsResponse {
  final List<NotificationsTopic> topics;

  GetUserSubscribedTopicsResponse({required this.topics});

  factory GetUserSubscribedTopicsResponse.fromJson(Map<String, dynamic> json) {
    return GetUserSubscribedTopicsResponse(
      topics:
          (json['data'] as List)
              .map((topic) => NotificationsTopic.fromJson(topic as Map<String, dynamic>))
              .toList(),
    );
  }
}
