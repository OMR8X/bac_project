enum NotificationStatus {
  unread('unread'),
  read('read'),
  deleted('deleted');

  const NotificationStatus(this.value);
  final String value;

  static NotificationStatus fromString(String value) {
    return NotificationStatus.values.firstWhere((status) => status.value == value, orElse: () => NotificationStatus.unread);
  }

  static bool isValid(String value) {
    return NotificationStatus.values.any((status) => status.value == value);
  }
}
