import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/notifications/domain/entities/app_notification.dart';
import 'package:neuro_app/features/notifications/domain/enums/notification_priority.dart';

part 'app_notification_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AppNotificationModel extends AppNotification {
  const AppNotificationModel({
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
    // Kept: mapping for mismatched DB/Dart field names
    @JsonKey(name: 'read_at') super.readAt,
  });

  static String _priorityToString(NotificationPriority priority) => priority.value;

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppNotificationModelToJson(this);
}
