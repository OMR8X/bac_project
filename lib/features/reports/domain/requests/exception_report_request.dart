import 'package:neuro_app/core/services/environment/environment_info.dart';
import 'package:neuro_app/features/reports/data/mappers/exception_report_mapper.dart';
import 'package:neuro_app/features/reports/domain/entities/exception_report.dart';

class ExceptionReportRequest {
  final String exceptionType;
  final String message;
  final String? stackTrace;
  final String? trigger;

  const ExceptionReportRequest({
    required this.exceptionType,
    required this.message,
    this.stackTrace,
    this.trigger,
  });

  Map<String, dynamic> toBody(EnvironmentInfo environmentInfo) {
    final entity = ExceptionReport(
      id: 0,
      exceptionType: exceptionType,
      message: message,
      stackTrace: stackTrace,
      trigger: trigger,
      appVersion: environmentInfo.appVersion,
      platform: environmentInfo.platform,
      deviceModel: environmentInfo.deviceModel,
      createdAt: DateTime.now(),
    );

    return {'p_exception_report': entity.toModel.toJson()};
  }
}
