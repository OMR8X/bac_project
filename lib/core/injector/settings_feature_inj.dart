import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/api/api_manager.dart';

import '../../features/settings/data/datasources/settings_remote_datasource.dart';
import '../../features/settings/data/datasources/settings_remote_datasource_impl.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_app_settings_usecase.dart';

Future<void> settingsFeatureInjection() async {
  // Datasource
  sl.registerLazySingleton<SettingsRemoteDatasource>(
    () => SettingsRemoteDatasourceImpl(apiManager: sl<ApiManager>()),
  );

  // Repository
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(remoteDataSource: sl()),
  );

  // Usecase
  sl.registerLazySingleton<GetAppSettingsUseCase>(() => GetAppSettingsUseCase(repository: sl()));
}
