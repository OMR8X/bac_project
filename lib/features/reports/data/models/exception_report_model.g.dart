// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exception_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExceptionReportModel _$ExceptionReportModelFromJson(
  Map<String, dynamic> json,
) => ExceptionReportModel(
  id: (json['id'] as num).toInt(),
  exceptionType: json['exception_type'] as String,
  message: json['message'] as String,
  stackTrace: json['stack_trace'] as String?,
  trigger: json['trigger'] as String?,
  appVersion: json['app_version'] as String?,
  platform: json['platform'] as String?,
  deviceModel: json['device_model'] as String?,
  userId: json['user_id'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ExceptionReportModelToJson(
  ExceptionReportModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'exception_type': instance.exceptionType,
  'message': instance.message,
  'stack_trace': instance.stackTrace,
  'trigger': instance.trigger,
  'app_version': instance.appVersion,
  'platform': instance.platform,
  'device_model': instance.deviceModel,
  'user_id': instance.userId,
  'created_at': instance.createdAt.toIso8601String(),
};
