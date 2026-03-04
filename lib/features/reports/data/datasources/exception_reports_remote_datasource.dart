import 'package:bac_project/core/services/api/api_constants.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/api/responses/api_response.dart';
import 'package:bac_project/core/services/environment/environment_info.dart';
import 'package:bac_project/features/reports/domain/requests/exception_report_request.dart';
import 'package:dartz/dartz.dart';

/// Abstract datasource for exception reports remote operations.
abstract class ExceptionReportsRemoteDatasource {
  /// Submits an exception report to the server.
  Future<Unit> submitExceptionReport(ExceptionReportRequest request);
}

/// Implementation of [ExceptionReportsRemoteDatasource] using ApiManager.
class ExceptionReportsRemoteDatasourceImplementation implements ExceptionReportsRemoteDatasource {
  final ApiManager _apiManager;
  final EnvironmentInfo _environmentInfo;

  ExceptionReportsRemoteDatasourceImplementation({
    required ApiManager apiManager,
    required EnvironmentInfo environmentInfo,
  }) : _apiManager = apiManager,
       _environmentInfo = environmentInfo;

  @override
  Future<Unit> submitExceptionReport(ExceptionReportRequest request) async {
    final response = await _apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.submitExceptionReportFunctionEndpoint),
      body: request.toBody(_environmentInfo),
    );

    ///
    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);

    ///
    apiResponse.throwErrorIfExists();

    return unit;
  }
}
