import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/cache/cache_constant.dart';
import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:bac_project/features/auth/domain/usecases/get_user_data_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/update_user_data_usecase.dart';
import 'package:bac_project/features/settings/domain/usecases/get_app_settings_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/initialize_notifications_usecase.dart';
import 'package:bac_project/presentation/auth/state/bloc/auth_bloc.dart';
import 'package:bac_project/presentation/home/blocs/home_bloc.dart';
import 'package:bac_project/presentation/result/bloc/explore_results/explore_results_bloc.dart';
import 'package:bac_project/presentation/result/bloc/submit_results/explore_result_bloc.dart';
import 'package:bac_project/presentation/search/bloc/bloc/search_bloc.dart';
import 'package:bac_project/presentation/tests/blocs/pick_lessons/pick_lessons_bloc.dart';
import 'package:bac_project/presentation/tests/blocs/test_mode_settings/test_mode_settings_bloc.dart';
import 'package:bac_project/presentation/tests/blocs/custom_questions/fetch_custom_questions_bloc.dart';

import '../../presentation/home/blocs/lessons_bloc.dart';

import '../../presentation/root/blocs/loader/app_loader_bloc.dart';
import '../../presentation/root/blocs/theme/app_theme_bloc.dart';

controllersInjection() {
  ///
  sl.registerSingleton(
    AppThemeBloc(cacheManager: sl<CacheManager>(), appThemeKey: CacheConstant.appThemeKey)
      ..add(const InitializeAppThemeEvent()),
  );

  ///
  sl.registerLazySingleton(
    () =>
        AppLoaderBloc(sl<GetAppSettingsUsecase>(), sl<InitializeNotificationsUsecase>())
          ..add(const AppLoaderLoadData()),
  );

  ///
  sl.registerLazySingleton(
    () => AuthBloc(
      sl<GetUserDataUsecase>(),
      sl<SignInUsecase>(),
      sl<SignUpUsecase>(),
      sl<SignOutUsecase>(),
      sl<UpdateUserDataUsecase>(),
    )..add(AuthInitializeEvent()),
  );

  sl.registerFactory(() => LessonsBloc());

  ///
  sl.registerFactory(
    () => TestModeSettingsBloc(getQuestionsUsecase: sl(), getTestOptionsUsecase: sl()),
  );

  ///
  sl.registerLazySingleton(() => HomeBloc());

  ///
  sl.registerFactory(() => PickLessonsBloc(getLessonsUsecase: sl()));

  ///
  sl.registerFactory(() => SearchBloc(getLessonsUsecase: sl()));

  ///
  sl.registerFactory(
    () => FetchCustomQuestionsBloc(getQuestionsByIdsUsecase: sl(), getResultUsecase: sl()),
  );

  // Results
  sl.registerLazySingleton(() => ExploreResultsBloc(getMyResultsUsecase: sl()));
  sl.registerFactory(() => ExploreResultBloc(getResultUsecase: sl()));
}
