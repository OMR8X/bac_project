import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';

class GetNotificationsResponse {
  final List<AppNotification> notifications;

  GetNotificationsResponse({required this.notifications});

  factory GetNotificationsResponse.fromJson(Map<String, dynamic> json) {
    return GetNotificationsResponse(
      notifications:
          (json['data'] as List)
              .map((notification) => AppNotification.fromJson(notification as Map<String, dynamic>))
              .toList(),
    );
  }
}
