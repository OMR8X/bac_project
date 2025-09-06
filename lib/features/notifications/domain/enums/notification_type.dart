enum NotificationType {
  direct('direct'),
  topic('topic'),
  broadcast('broadcast');

  const NotificationType(this.value);
  final String value;

  static NotificationType fromString(String value) {
    return NotificationType.values.firstWhere((type) => type.value == value, orElse: () => NotificationType.direct);
  }

  static bool isValid(String value) {
    return NotificationType.values.any((type) => type.value == value);
  }
}
