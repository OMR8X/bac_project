import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:bac_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bac_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:bac_project/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/get_user_data_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/remove_from_user_favorites_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/update_user_data_usecase.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_implement.dart';
import '../../features/auth/domain/usecases/add_to_user_favorites_usecase.dart';
import '../../features/auth/domain/usecases/get_user_favorites_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';

authFeatureInjection() {
  injectUsecases();
  injectRepositories();
  injectDataSources();
}

void injectUsecases() {
  sl.registerFactory<GetUserDataUsecase>(
    () => GetUserDataUsecase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<GetUserFavoritesUsecase>(
    () => GetUserFavoritesUsecase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<AddToUserFavoritesUsecase>(
    () => AddToUserFavoritesUsecase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<RemoveFromUserFavoritesUsecase>(
    () => RemoveFromUserFavoritesUsecase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<SignUpUsecase>(() => SignUpUsecase(repository: sl<AuthRepository>()));
  sl.registerFactory<SignInUsecase>(() => SignInUsecase(repository: sl<AuthRepository>()));
  sl.registerFactory<ChangePasswordUsecase>(
    () => ChangePasswordUsecase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<ForgetPasswordUsecase>(
    () => ForgetPasswordUsecase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<UpdateUserDataUsecase>(
    () => UpdateUserDataUsecase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<SignOutUsecase>(() => SignOutUsecase(repository: sl<AuthRepository>()));
}

void injectRepositories() async {
  sl.registerFactory<AuthRepository>(
    () => AuthRepositoryImplement(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
      cacheManager: sl<CacheManager>(),
    ),
  );
}

void injectDataSources() async {
  sl.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplements(apiManager: sl<ApiManager>()),
  );
  sl.registerFactory<AuthLocalDataSource>(
    () => AuthLocalDataSourceImplements(cacheManager: sl<CacheManager>()),
  );
}
