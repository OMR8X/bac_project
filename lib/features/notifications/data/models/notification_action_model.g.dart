// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationActionModel _$NotificationActionModelFromJson(
  Map<String, dynamic> json,
) => NotificationActionModel(
  label: json['label'] as String,
  type: $enumDecode(_$NotificationActionTypeEnumMap, json['type']),
  uri: json['uri'] as String,
);

Map<String, dynamic> _$NotificationActionModelToJson(
  NotificationActionModel instance,
) => <String, dynamic>{
  'label': instance.label,
  'type': _$NotificationActionTypeEnumMap[instance.type]!,
  'uri': instance.uri,
};

const _$NotificationActionTypeEnumMap = {
  NotificationActionType.screen: 'screen',
  NotificationActionType.http: 'http',
};
