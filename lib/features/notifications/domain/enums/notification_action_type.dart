enum NotificationActionType {
  screen('screen'),
  http('http');

  const NotificationActionType(this.value);
  final String value;

  static NotificationActionType fromString(String value) {
    return NotificationActionType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => NotificationActionType.screen,
    );
  }

  static bool isValid(String value) {
    return NotificationActionType.values.any((type) => type.value == value);
  }
}
