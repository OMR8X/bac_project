import 'package:bac_project/features/reports/data/models/exception_report_model.dart';
import 'package:bac_project/features/reports/domain/entities/exception_report.dart';

extension ExceptionReportModelMapper on ExceptionReportModel {
  ExceptionReport get toEntity {
    return ExceptionReport(
      id: id,
      exceptionType: exceptionType,
      message: message,
      stackTrace: stackTrace,
      trigger: trigger,
      appVersion: appVersion,
      platform: platform,
      deviceModel: deviceModel,
      userId: userId,
      createdAt: createdAt,
    );
  }
}

extension ExceptionReportMapper on ExceptionReport {
  ExceptionReportModel get toModel {
    return ExceptionReportModel(
      id: id,
      exceptionType: exceptionType,
      message: message,
      stackTrace: stackTrace,
      trigger: trigger,
      appVersion: appVersion,
      platform: platform,
      deviceModel: deviceModel,
      userId: userId,
      createdAt: createdAt,
    );
  }
}
