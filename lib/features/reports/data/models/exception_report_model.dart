import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/reports/domain/entities/exception_report.dart';

part 'exception_report_model.g.dart';

/// Data model for exception reports with JSON serialization.
@JsonSerializable(fieldRename: FieldRename.snake)
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
    super.updatedAt,
  });

  factory ExceptionReportModel.fromJson(Map<String, dynamic> json) =>
      _$ExceptionReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExceptionReportModelToJson(this);
}
