import 'package:neuro_app/features/notifications/data/models/app_notification_model.dart';
import 'package:neuro_app/features/notifications/domain/entities/app_notification.dart';

class GetNotificationsResponse {
  final List<AppNotification> notifications;

  GetNotificationsResponse({required this.notifications});

  factory GetNotificationsResponse.fromJson(Map<String, dynamic> json) {
    return GetNotificationsResponse(
      notifications:
          (json['notifications'] as List<dynamic>?)?.map(
            (notification) {
              return AppNotificationModel.fromDatabaseJson(notification as Map<String, dynamic>);
            },
          ).toList() ??
          [],
    );
  }
}
