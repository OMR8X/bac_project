import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/environment/environment_info.dart';
import 'package:bac_project/features/reports/data/datasources/exception_reports_remote_datasource.dart';
import 'package:bac_project/features/reports/data/repositories/exception_reports_repository_implementation.dart';
import 'package:bac_project/features/reports/domain/repositories/exception_reports_repository.dart';
import 'package:bac_project/features/reports/domain/usecases/submit_exception_report_usecase.dart';

Future<void> reportsFeatureInjection() async {
  // Datasources
  sl.registerLazySingleton<ExceptionReportsRemoteDatasource>(
    () => ExceptionReportsRemoteDatasourceImplementation(
      apiManager: sl<ApiManager>(),
      environmentInfo: sl<EnvironmentInfo>(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<ExceptionReportsRepository>(
    () => ExceptionReportsRepositoryImplementation(
      sl<ExceptionReportsRemoteDatasource>(),
    ),
  );

  // Usecases
  sl.registerFactory<SubmitExceptionReportUsecase>(
    () => SubmitExceptionReportUsecase(repository: sl()),
  );
}
