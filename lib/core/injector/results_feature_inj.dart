import 'package:get_it/get_it.dart';

import '../../features/results/data/datasources/results_remote_data_source.dart';
import '../../features/results/data/datasources/results_remote_data_source_impl.dart';
import '../../features/results/data/repositories/results_repository_impl.dart';
import '../../features/results/domain/repositories/results_repository.dart';
import '../../features/results/domain/usecases/add_result_use_case.dart';
import '../../features/results/domain/usecases/get_answer_evaluations_use_case.dart';
import '../../features/results/domain/usecases/get_my_results_use_case.dart';
import '../../features/results/domain/usecases/get_result_leaderboard_use_case.dart';
import '../../features/results/domain/usecases/get_result_questions_details_use_case.dart';
import '../../features/results/domain/usecases/get_result_use_case.dart';

final sl = GetIt.instance;

Future<void> resultsFeatureInjection() async {
  datasources();
  repositories();
  usecases();
}

Future<void> datasources() async {
  sl.registerLazySingleton<ResultsRemoteDataSource>(
    () => ResultsRemoteDataSourceImpl(apiManager: sl()),
  );
}

Future<void> repositories() async {
  sl.registerLazySingleton<ResultsRepository>(() => ResultsRepositoryImpl(remoteDataSource: sl()));
}

Future<void> usecases() async {
  sl.registerLazySingleton<AddResultUsecase>(() => AddResultUsecase(repository: sl()));
  sl.registerLazySingleton<GetMyResultsUsecase>(() => GetMyResultsUsecase(repository: sl()));
  sl.registerLazySingleton<GetResultUsecase>(() => GetResultUsecase(repository: sl()));
  sl.registerLazySingleton<GetResultLeaderboardUsecase>(
    () => GetResultLeaderboardUsecase(repository: sl()),
  );
  sl.registerLazySingleton<GetResultQuestionsDetailsUsecase>(
    () => GetResultQuestionsDetailsUsecase(repository: sl()),
  );
  sl.registerLazySingleton<GetAnswerEvaluationsUsecase>(
    () => GetAnswerEvaluationsUsecase(repository: sl()),
  );
}
