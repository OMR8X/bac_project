import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/reports/domain/requests/exception_report_request.dart';
import 'package:dartz/dartz.dart';

/// Abstract repository for exception reports operations.
abstract class ExceptionReportsRepository {
  /// Submits an exception report to the server.
  Future<Either<Failure, Unit>> submitExceptionReport(
    ExceptionReportRequest request,
  );
}
