import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/notifications/domain/entities/user_notification.dart';

part 'user_notification_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserNotificationModel extends UserNotification {
  const UserNotificationModel({
    required super.id,
    required super.userId,
    required super.notificationId,
    super.deliveredAt,
    super.readAt,
    super.dismissedAt,
    super.actionPerformed,
  });

  factory UserNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserNotificationModelToJson(this);

  Map<String, dynamic> toDatabaseJson() => _$UserNotificationModelToJson(this);
}
