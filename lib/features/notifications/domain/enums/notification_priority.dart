enum NotificationPriority {
  low('low'),
  normal('normal'),
  high('high');

  const NotificationPriority(this.value);
  final String value;

  static NotificationPriority fromString(String value) {
    return NotificationPriority.values.firstWhere(
      (priority) => priority.value == value,
      orElse: () => NotificationPriority.normal,
    );
  }

  static bool isValid(String value) {
    return NotificationPriority.values.any((priority) => priority.value == value);
  }
}
