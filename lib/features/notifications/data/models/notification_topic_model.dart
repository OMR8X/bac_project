import 'package:bac_project/features/notifications/domain/entities/notifications_topic.dart';

class NotificationTopicModel extends NotificationsTopic {
  const NotificationTopicModel({
    required super.id,
    required super.title,
    super.description,
    required super.firebaseTopic,
    super.subscribable,
  });

  factory NotificationTopicModel.fromJson(Map<String, dynamic> json) {
    return NotificationTopicModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      firebaseTopic: json['firebase_topic'] as String,
      subscribable: json['subscribable'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'firebase_topic': firebaseTopic,
      'subscribable': subscribable,
    };
  }
}
