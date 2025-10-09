import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../enums/notification_action_type.dart';

class NotificationAction extends Equatable {
  final String label;
  final NotificationActionType type;
  final String uri;

  const NotificationAction({
    required this.label,
    required this.type,
    required this.uri,
  });

  String get actionId => label;

  factory NotificationAction.empty() {
    return const NotificationAction(
      label: '',
      type: NotificationActionType.screen,
      uri: '',
    );
  }
  AndroidNotificationAction toAndroidNotificationAction() {
    return AndroidNotificationAction(
      actionId,
      label,
      showsUserInterface: type != NotificationActionType.http,
    );
  }

  NotificationAction copyWith({
    String? label,
    NotificationActionType? type,
    String? uri,
  }) {
    return NotificationAction(
      label: label ?? this.label,
      type: type ?? this.type,
      uri: uri ?? this.uri,
    );
  }

  @override
  List<Object?> get props => [label, type, uri];
}
