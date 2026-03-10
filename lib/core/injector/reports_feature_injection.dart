import 'package:neuro_app/core/injector/app_injection.dart';
import 'package:neuro_app/core/services/api/api_manager.dart';
import 'package:neuro_app/core/services/environment/environment_info.dart';
import 'package:neuro_app/features/reports/data/datasources/exception_reports_remote_datasource.dart';
import 'package:neuro_app/features/reports/data/repositories/exception_reports_repository_implementation.dart';
import 'package:neuro_app/features/reports/domain/repositories/exception_reports_repository.dart';
import 'package:neuro_app/features/reports/domain/usecases/submit_exception_report_usecase.dart';

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
