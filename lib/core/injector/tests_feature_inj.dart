import 'package:bac_project/features/tests/domain/usecases/get_lessons_use_case.dart';
import 'package:bac_project/features/tests/domain/usecases/get_questions_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../features/tests/data/datasources/tests_remote_data_source.dart';
import '../../features/tests/data/datasources/tests_remote_data_source_impl.dart';
import '../../features/tests/data/repositories/tests_repository_impl.dart';
import '../../features/tests/domain/repositories/tests_repository.dart';
import '../../features/tests/domain/usecases/get_units_use_case.dart';
import '../../features/tests/data/datasources/results_remote_data_source.dart';
import '../../features/tests/data/datasources/results_remote_data_source_impl.dart';
import '../../features/tests/data/repositories/results_repository_impl.dart';
import '../../features/tests/domain/repositories/results_repository.dart';
import '../../features/tests/domain/usecases/add_result_use_case.dart';
import '../../features/tests/domain/usecases/get_my_results_use_case.dart';

final sl = GetIt.instance;

Future<void> testsFeatureInjection() async {
  datasources();
  repositories();
  usecases();
}

Future<void> datasources() async {
  sl.registerLazySingleton<TestsRemoteDataSource>(
    () => TestsRemoteDataSourceImpl(client: sl(), apiManager: sl()),
  );
  sl.registerLazySingleton<ResultsRemoteDataSource>(
    () => ResultsRemoteDataSourceImpl(apiManager: sl()),
  );
}

Future<void> repositories() async {
  sl.registerLazySingleton<TestsRepository>(() => TestsRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ResultsRepository>(() => ResultsRepositoryImpl(remoteDataSource: sl()));
}

Future<void> usecases() async {
  sl.registerLazySingleton<GetUnitsUseCase>(() => GetUnitsUseCase(repository: sl()));
  sl.registerLazySingleton<GetLessonsUseCase>(() => GetLessonsUseCase(repository: sl()));
  sl.registerLazySingleton<GetQuestionsUseCase>(() => GetQuestionsUseCase(repository: sl()));
  sl.registerLazySingleton<AddResultUseCase>(() => AddResultUseCase(repository: sl()));
  sl.registerLazySingleton<GetMyResultsUseCase>(() => GetMyResultsUseCase(repository: sl()));
}
