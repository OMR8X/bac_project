import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';

class GetNotificationsResponse {
  final List<AppNotification> notifications;

  GetNotificationsResponse({required this.notifications});
}
