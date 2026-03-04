import 'package:bac_project/features/reports/domain/entities/exception_report.dart';

/// Data model for exception reports with JSON serialization.
class ExceptionReportModel extends ExceptionReport {
  const ExceptionReportModel({
    required super.id,
    required super.exceptionType,
    required super.message,
    super.stackTrace,
    super.trigger,
    super.appVersion,
    super.platform,
    super.deviceModel,
    super.userId,
    required super.createdAt,
  });

  factory ExceptionReportModel.fromJson(Map<String, dynamic> json) {
    return ExceptionReportModel(
      id: json['id'] as int,
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
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exception_type': exceptionType,
      'message': message,
      'stack_trace': stackTrace,
      'trigger': trigger,
      'app_version': appVersion,
      'platform': platform,
      'device_model': deviceModel,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
