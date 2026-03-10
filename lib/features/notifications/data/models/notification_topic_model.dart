import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/notifications/domain/entities/notifications_topic.dart';

part 'notification_topic_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationTopicModel extends NotificationsTopic {
  const NotificationTopicModel({
    required super.id,
    required super.title,
    super.description,
    required super.firebaseTopic,
    super.subscribable,
  });

  factory NotificationTopicModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationTopicModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotificationTopicModelToJson(this);

  Map<String, dynamic> toDatabaseJson() => _$NotificationTopicModelToJson(this);
}
