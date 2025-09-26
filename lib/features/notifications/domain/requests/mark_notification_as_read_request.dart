class MarkNotificationAsReadRequest {
  final String notificationId;

  MarkNotificationAsReadRequest({
    required this.notificationId,
  });

  Map<String, dynamic> toJsonBody() {
    return {
      'p_notification_id': notificationId,
    };
  }
}
