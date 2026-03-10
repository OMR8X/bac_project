import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/notifications/domain/entities/notification.dart';
import 'package:neuro_app/features/notifications/domain/enums/notification_priority.dart';

part 'notification_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationModel extends Notification {
  const NotificationModel({
    required super.id,
    required super.topicId,
    super.topicTitle,
    required super.title,
    required super.body,
    super.imageUrl,
    super.payload,
    // Kept: custom enum from/to string mapping
    @JsonKey(fromJson: NotificationPriority.fromString, toJson: _priorityToString)
    required super.priority,
    required super.createdAt,
    super.expiresAt,
  });

  static String _priorityToString(NotificationPriority priority) => priority.value;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  Map<String, dynamic> toDatabaseJson() => _$NotificationModelToJson(this);
}
