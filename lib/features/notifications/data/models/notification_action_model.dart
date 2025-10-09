import 'package:bac_project/features/notifications/domain/entities/notification_action.dart';
import 'package:bac_project/features/notifications/domain/enums/notification_action_type.dart';

class NotificationActionModel extends NotificationAction {
  const NotificationActionModel({
    required super.label,
    required super.type,
    required super.uri,
  });

  factory NotificationActionModel.fromJson(Map<String, dynamic> json) {
    return NotificationActionModel(
      label: json['label'] as String,
      type: NotificationActionType.fromString(json['type'] ?? 'screen'),
      uri: json['uri'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'type': type.value,
      'uri': uri,
    };
  }
}
