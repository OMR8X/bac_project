import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/cache/cache_constant.dart';
import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:bac_project/presentation/home/blocs/home_bloc.dart';
import 'package:bac_project/presentation/tests/blocs/test_mode_settings_bloc.dart';

import '../../presentation/root/blocs/auth/auth_bloc.dart';
import '../../presentation/home/blocs/lessons_bloc.dart';

import '../../presentation/root/blocs/loader/app_loader_bloc.dart';
import '../../presentation/root/blocs/theme/app_theme_bloc.dart';

controllersInjection() {
  ///
  sl.registerSingleton(
    AppThemeBloc(
      cacheManager: sl<CacheManager>(),
      appThemeKey: CacheConstant.appThemeKey,
    )..add(const InitializeAppThemeEvent()),
  );

  ///
  sl.registerSingleton(AppLoaderBloc()..add(const AppLoaderLoadData()));

  ///
  sl.registerSingleton(AuthBloc()..add(const AuthInitializeEvent()));

  sl.registerFactory(() => LessonsBloc());

  ///
  sl.registerFactory(() => TestModeSettingsBloc());

  ///
  sl.registerSingleton(HomeBloc());

  ///
}
