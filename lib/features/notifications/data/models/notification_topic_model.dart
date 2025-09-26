import 'package:bac_project/features/notifications/domain/entities/notifications_topic.dart';

class NotificationTopicModel extends NotificationsTopic {
  const NotificationTopicModel({required super.id, required super.name, super.description});

  factory NotificationTopicModel.fromJson(Map<String, dynamic> json) {
    return NotificationTopicModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toDatabaseJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
