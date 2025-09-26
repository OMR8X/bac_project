import 'package:bac_project/features/notifications/domain/entities/notification_type.dart';

class NotificationTypeModel extends NotificationType {
  const NotificationTypeModel({required super.id, required super.name, super.description});

  factory NotificationTypeModel.fromJson(Map<String, dynamic> json) {
    return NotificationTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toDatabaseJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
