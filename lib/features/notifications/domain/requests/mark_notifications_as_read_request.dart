class MarkNotificationsAsReadRequest {
  final List<String> notificationIds;

  MarkNotificationsAsReadRequest({
    required this.notificationIds,
  });

  Map<String, dynamic> toJsonBody() {
    return {
      'p_notification_ids': notificationIds,
    };
  }
}
