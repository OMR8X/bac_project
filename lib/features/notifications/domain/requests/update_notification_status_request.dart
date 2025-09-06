class UpdateNotificationStatusRequest {
  final String notificationId;
  final String status;
  final DateTime? readAt;

  UpdateNotificationStatusRequest({required this.notificationId, required this.status, this.readAt});
}
