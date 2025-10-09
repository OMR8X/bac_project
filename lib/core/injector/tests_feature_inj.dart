import 'package:get_it/get_it.dart';

import '../../features/tests/data/datasources/tests_remote_data_source.dart';
import '../../features/tests/data/datasources/tests_remote_data_source_impl.dart';
import '../../features/tests/data/repositories/tests_repository_impl.dart';
import '../../features/tests/domain/repositories/tests_repository.dart';
import '../../features/tests/domain/usecases/get_lessons_use_case.dart';
import '../../features/tests/domain/usecases/get_questions_by_ids_use_case.dart';
import '../../features/tests/domain/usecases/get_questions_use_case.dart';
import '../../features/tests/domain/usecases/get_test_options_use_case.dart';
import '../../features/tests/domain/usecases/get_units_use_case.dart';

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
}

Future<void> repositories() async {
  sl.registerLazySingleton<TestsRepository>(() => TestsRepositoryImpl(remoteDataSource: sl()));
}

Future<void> usecases() async {
  sl.registerLazySingleton<GetUnitsUsecase>(() => GetUnitsUsecase(repository: sl()));
  sl.registerLazySingleton<GetLessonsUsecase>(() => GetLessonsUsecase(repository: sl()));
  sl.registerLazySingleton<GetQuestionsUsecase>(() => GetQuestionsUsecase(repository: sl()));
  sl.registerLazySingleton<GetTestOptionsUsecase>(() => GetTestOptionsUsecase(repository: sl()));
  sl.registerLazySingleton<GetQuestionsByIdsUsecase>(
    () => GetQuestionsByIdsUsecase(repository: sl()),
  );
}
