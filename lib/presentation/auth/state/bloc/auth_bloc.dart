import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/core/widgets/messages/snackbars/success_snackbar_widget.dart';
import 'package:bac_project/features/auth/data/responses/sign_in_response.dart';
import 'package:bac_project/features/auth/data/responses/sign_out_response.dart';
import 'package:bac_project/features/auth/data/responses/sign_up_response.dart';
import 'package:bac_project/features/auth/data/responses/update_user_data_response.dart';
import 'package:bac_project/features/auth/domain/requests/sign_out_request.dart';
import 'package:bac_project/features/auth/domain/requests/update_user_data_request.dart';
import 'package:bac_project/features/auth/domain/usecases/get_user_data_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:bac_project/features/auth/domain/usecases/update_user_data_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/refresh_device_token_usecase.dart';
import 'package:bac_project/features/settings/domain/entities/app_settings.dart';
import 'package:bac_project/features/settings/domain/entities/governorate.dart';
import 'package:bac_project/features/settings/domain/entities/section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import '../../../../features/auth/domain/requests/get_user_data_request.dart';
import '../../../../features/auth/domain/requests/sign_in_request.dart';
import '../../../../features/auth/domain/requests/sign_up_request.dart';
import '../../../../features/auth/domain/entites/user_data.dart';
import '../../../../core/injector/app_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../features/notifications/domain/usecases/get_device_token_usecase.dart';
import '../../../root/blocs/navigation/navigation_cubit.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUserDataUsecase _getUserDataUsecase;
  final SignInUsecase _signInUsecase;
  final SignUpUsecase _signUpUsecase;
  final SignOutUsecase _signOutUsecase;
  // final DeleteDeviceTokenUsecase _deleteDeviceTokenUsecase;
  final UpdateUserDataUsecase _updateUserDataUsecase;

  AuthBloc(
    this._getUserDataUsecase,
    this._signInUsecase,
    this._signUpUsecase,
    this._signOutUsecase,
    this._updateUserDataUsecase,
    // this._deleteDeviceTokenUsecase,
  ) : super(const AuthLoadingState()) {
    //
    on<AuthInitializeEvent>(onAuthInitializeEvent);
    //
    on<AuthStartAuthenticationEvent>((event, emit) => emit(const AuthStartState()));
    //
    on<AuthStartSignInEvent>((event, emit) => emit(const AuthSigningInState()));
    on<AuthStartSignUpEvent>(
      (event, emit) => emit(
        AuthSigningUpState(
          governorates: sl<AppSettings>().governorates,
          sections: sl<AppSettings>().sections,
        ),
      ),
    );
    //
    on<AuthSignInEvent>(onAuthSignInEvent);
    on<AuthSignUpEvent>(onAuthSignUpEvent);
    on<AuthSignOutEvent>(onAuthSignOutEvent);
    on<AuthUpdateUserDataEvent>(onAuthUpdateUserDataEvent);
    //
  }
  //
  onAuthInitializeEvent(AuthInitializeEvent event, Emitter<AuthenticationState> emit) async {
    //
    emit(const AuthLoadingState());
    //
    final response = await _getUserDataUsecase(request: GetUserDataRequest());
    //
    response.fold(
      (failure) {
        emit(AuthStartState(failure: failure));
      },
      (r) async {
        _injectUserData(r.user);
        emit(const AuthDoneState());
      },
    );
  }

  //
  onAuthSignInEvent(AuthSignInEvent event, Emitter<AuthenticationState> emit) async {
    //
    final String email = event.email.trim().toLowerCase();
    final String password = event.password.trim();

    //
    final signUpRequest = SignInRequest(
      email: email,
      firebaseToken: await getFirebaseDeviceToken(),
      password: password,
    );
    //
    emit(const AuthSigningInState(loading: true));
    //
    final response = await _signInUsecase(request: signUpRequest);
    //
    response.fold(
      (l) {
        emit(AuthSigningInState(loading: false, failure: l));
      },
      (SignInResponse r) {
        emit(AuthSigningInState(loading: false, failure: null, successMessage: r.message));
        sl<AuthBloc>().add(const AuthInitializeEvent());
      },
    );
    //
  }

  //
  onAuthSignUpEvent(AuthSignUpEvent event, Emitter<AuthenticationState> emit) async {
    //
    final String name = event.name.trim();
    final String email = event.email.trim().toLowerCase();
    final int sectionId = event.sectionId;
    final int governorateId = event.governorateId;
    final String password = event.password.trim();
    //
    final signUpRequest = SignUpRequest(
      name: name,
      firebaseToken: await getFirebaseDeviceToken(),
      email: email,
      sectionId: sectionId,
      governorateId: governorateId,
      password: password,
    );
    //
    emit(const AuthSigningUpState(loading: true));
    //
    final response = await _signUpUsecase(request: signUpRequest);
    //
    response.fold(
      (l) {
        emit(AuthSigningUpState(loading: false, failure: l));
      },
      (SignUpResponse r) {
        emit(AuthSigningUpState(loading: false, failure: null, successMessage: r.message));
        sl<AuthBloc>().add(const AuthInitializeEvent());
      },
    );
    //
  }

  //
  onAuthUpdateUserDataEvent(
    AuthUpdateUserDataEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    //
    emit(const AuthLoadingState(loading: true));
    //
    final String? name = event.name?.trim();
    final String? email = event.email?.trim();
    final int? governorateId = event.governorateId;
    final int? sectionId = event.sectionId;
    final String? password = event.password?.trim();
    //
    final updateUserDataRequest = UpdateUserDataRequest(
      name: name,
      email: email,
      governorateId: governorateId,
      sectionId: sectionId,
      password: password,
    );
    //
    final response = await _updateUserDataUsecase(request: updateUserDataRequest);
    //
    response.fold(
      (l) {
        emit(AuthDoneState(loading: false, failure: l));
      },
      (UpdateUserDataResponse r) {
        _injectUserData(r.user);
        //
        emit(AuthDoneState(loading: false, failure: null, successMessage: r.message));
        AppRouter.router.pop();
      },
    );
    //
  }

  //
  onAuthSignOutEvent(AuthSignOutEvent event, Emitter<AuthenticationState> emit) async {
    //
    emit(const AuthLoadingState());
    //
    final response = await _signOutUsecase(request: SignOutRequest());
    //
    response.fold(
      (l) {
        emit(AuthStartState(loading: false, failure: l));
      },
      (SignOutResponse r) async {
        /// Initialize the auth bloc
        add(const AuthInitializeEvent());
        AppRouter.router.go(Routes.authentication.path);

        /// Show success message
        final context = AppRouter.rootNavigatorKey.currentContext;
        if (context != null && r.message != null) {
          showSuccessSnackbar(context: context, title: r.message!);
        }
        sl<NavigationCubit>().updateFromAuthenticationState(const AuthStartState());
      },
    );
    //
  }

  Future<void> _injectUserData(UserData data) async {
    //
    if (sl.isRegistered<UserData>()) {
      sl.unregister<UserData>();
    }
    //
    sl.registerSingleton<UserData>(data);

    return;
  }

  Future<String?> getFirebaseDeviceToken() async {
    //
    final tokenResponse = await sl<GetDeviceTokenUsecase>().call();
    //
    return tokenResponse.fold((l) => null, (r) => r);
  }

  Future<void> deleteFirebaseDeviceToken() async {
    //
    final tokenResponse = await sl<RefreshDeviceTokenUsecase>().call();
    //
    return tokenResponse.fold((l) => null, (r) => r);
  }
}
