import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/services/logs/logger.dart';
import 'package:bac_project/features/auth/domain/entites/user_data.dart';
import 'package:bac_project/features/notifications/domain/requests/register_device_token_request.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_device_token_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/register_device_token_usecase.dart';
import 'package:bac_project/features/settings/domain/entities/version.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bac_project/features/settings/domain/usecases/get_app_settings_usecase.dart';
import 'package:bac_project/features/settings/domain/requests/get_app_settings_request.dart';
import 'package:bac_project/features/settings/domain/entities/app_settings.dart';
import 'package:bac_project/features/notifications/domain/usecases/initialize_notifications_usecase.dart';
part 'app_loader_event.dart';
part 'app_loader_state.dart';

class AppLoaderBloc extends Bloc<AppLoaderLoadData, AppLoaderState> {
  final GetAppSettingsUsecase _getAppSettingsUsecase;
  final InitializeNotificationsUsecase _initializeNotificationsUsecase;

  AppLoaderBloc(this._getAppSettingsUsecase, this._initializeNotificationsUsecase)
    : super(AppLoaderState.loading()) {
    on<AppLoaderLoadData>(onAppLoaderLoadData);
  }

  onAppLoaderLoadData(AppLoaderLoadData event, Emitter<AppLoaderState> emit) async {
    emit(AppLoaderState.loading());

    ///
    await _initializeNotificationsUsecase.call();

    ///
    try {
      final result = await _getAppSettingsUsecase.call(request: const GetAppSettingsRequest());
      result.fold(
        (failure) {
          emit(AppLoaderState.failure(failure: failure));
        },
        (response) async {
          registerAppSettings(response.appSettings);
          if (response.appSettings.version.updateAvailable) {
            emit(AppLoaderState.update(version: response.appSettings.version));
          } else if (response.appSettings.userData == null) {
            emit(AppLoaderState.unauthorized());
          } else {
            _injectUserData(response.appSettings.userData!);
            emit(AppLoaderState.succeed());
          }
        },
      ); // REI AMI
    } on Exception catch (e) {
      emit(AppLoaderState.failure(failure: UnknownFailure(message: e.toString())));
    }
  }

  registerAppSettings(AppSettings appSettings) {
    try {
      if (sl.isRegistered<AppSettings>()) {
        sl.unregister<AppSettings>();
      }
      sl.registerSingleton<AppSettings>(appSettings);
    } catch (_) {}
  }

  Future<void> _injectUserData(UserData data) async {
    //
    if (sl.isRegistered<UserData>()) {
      sl.unregister<UserData>();
    }
    //
    sl.registerSingleton<UserData>(data);
    await registerDeviceToken();
    return;
  }

  Future<void> registerDeviceToken() async {
    final deviceTokenResult = await sl<GetDeviceTokenUsecase>().call();
    await deviceTokenResult.fold(
      (l) {
        Logger.error('Failed to get device token: $l');
      },
      (
        deviceToken,
      ) async {
        Logger.message('Device token: $deviceToken');
        await sl<RegisterDeviceTokenUsecase>().call(
          await RegisterDeviceTokenRequest.fromDeviceToken(deviceToken),
        );
      },
    );
  }
}
