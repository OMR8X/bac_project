import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/reports/domain/repositories/exception_reports_repository.dart';
import 'package:bac_project/features/reports/domain/requests/exception_report_request.dart';
import 'package:dartz/dartz.dart';

/// Use case for submitting an exception report.
class SubmitExceptionReportUsecase {
  final ExceptionReportsRepository repository;

  SubmitExceptionReportUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(ExceptionReportRequest request) async {
    return await repository.submitExceptionReport(request);
  }
}
