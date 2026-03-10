import 'package:neuro_app/core/resources/errors/failures.dart';
import 'package:neuro_app/features/reports/data/datasources/exception_reports_remote_datasource.dart';
import 'package:neuro_app/features/reports/domain/repositories/exception_reports_repository.dart';
import 'package:neuro_app/features/reports/domain/requests/exception_report_request.dart';
import 'package:dartz/dartz.dart';

/// Implementation of [ExceptionReportsRepository].
class ExceptionReportsRepositoryImplementation
    implements ExceptionReportsRepository {
  final ExceptionReportsRemoteDatasource _remoteDatasource;

  ExceptionReportsRepositoryImplementation(this._remoteDatasource);

  @override
  Future<Either<Failure, Unit>> submitExceptionReport(
    ExceptionReportRequest request,
  ) async {
    try {
      await _remoteDatasource.submitExceptionReport(request);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
