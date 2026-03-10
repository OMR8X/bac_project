import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/notifications/domain/entities/notification_action.dart';
import 'package:neuro_app/features/notifications/domain/enums/notification_action_type.dart';

part 'notification_action_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationActionModel extends NotificationAction {
  const NotificationActionModel({
    required super.label,
    // Kept: custom enum from/to string mapping
    @JsonKey(fromJson: NotificationActionType.fromString, toJson: _typeToString)
    required super.type,
    required super.uri,
  });

  static String _typeToString(NotificationActionType type) => type.value;

  factory NotificationActionModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationActionModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationActionModelToJson(this);
}
