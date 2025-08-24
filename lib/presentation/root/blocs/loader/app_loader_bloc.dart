import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/settings/domain/entities/version.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bac_project/features/settings/domain/usecases/get_app_settings_usecase.dart';
import 'package:bac_project/features/settings/domain/requests/get_app_settings_request.dart';
import 'package:bac_project/features/settings/domain/entities/app_settings.dart';
part 'app_loader_event.dart';
part 'app_loader_state.dart';

class AppLoaderBloc extends Bloc<AppLoaderLoadData, AppLoaderState> {
  final GetAppSettingsUseCase _getAppSettingsUseCase;

  AppLoaderBloc(this._getAppSettingsUseCase) : super(AppLoaderState.loading()) {
    on<AppLoaderLoadData>(onAppLoaderLoadData);
  }

  onAppLoaderLoadData(AppLoaderLoadData event, Emitter<AppLoaderState> emit) async {
    emit(AppLoaderState.loading());

    try {
      final result = await _getAppSettingsUseCase.call(request: const GetAppSettingsRequest());
      result.fold(
        (failure) {
          emit(AppLoaderState.failure(failure: failure));
        },
        (response) {
          registerAppSettings(response.appSettings);
          if (response.appSettings.version.updateAvailable) {
            emit(AppLoaderState.update(version: response.appSettings.version));
          } else {
            emit(AppLoaderState.succeed());
          }
        },
      );
    } on Exception catch (e) {
      emit(AppLoaderState.failure(failure: AnonFailure(message: e.toString())));
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
}
