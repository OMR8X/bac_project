import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/services/router/index.dart';
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
import '../../../../features/auth/domain/requests/get_user_data_request.dart';
import '../../../../features/auth/domain/requests/sign_in_request.dart';
import '../../../../features/auth/domain/requests/sign_up_request.dart';
import '../../../../features/auth/domain/entites/user_data.dart';
import '../../../../core/injector/app_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:equatable/equatable.dart';

import '../../../../features/notifications/domain/usecases/get_device_token_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
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
    on<AuthStartAuthEvent>((event, emit) => emit(const AuthStartState()));
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
  onAuthInitializeEvent(AuthInitializeEvent event, Emitter<AuthState> emit) async {
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
  onAuthSignInEvent(AuthSignInEvent event, Emitter<AuthState> emit) async {
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
        Fluttertoast.showToast(msg: l.message);
        emit(AuthSigningInState(loading: false, failure: l));
      },
      (r) {
        Fluttertoast.showToast(msg: r.message);
        emit(const AuthSigningInState(loading: false, failure: null));
        sl<AuthBloc>().add(const AuthInitializeEvent());
      },
    );
    //
  }

  //
  onAuthSignUpEvent(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    //
    final String name = event.name.trim();
    final String email = event.email.trim().toLowerCase();
    final String sectionId = event.sectionId.trim();
    final String governorateId = event.governorateId.trim();
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
        Fluttertoast.showToast(msg: l.message);
        emit(AuthSigningUpState(loading: false, failure: l));
      },
      (r) {
        Fluttertoast.showToast(msg: r.message);
        emit(const AuthSigningUpState(loading: false, failure: null));
        sl<AuthBloc>().add(const AuthInitializeEvent());
      },
    );
    //
  }

  //
  onAuthUpdateUserDataEvent(AuthUpdateUserDataEvent event, Emitter<AuthState> emit) async {
    //
    emit(const AuthLoadingState(loading: true));
    //
    final String? name = event.name?.trim();
    final String? email = event.email?.trim();
    final String? governorateId = event.governorateId;
    final String? sectionId = event.sectionId;
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
        Fluttertoast.showToast(msg: l.message);
        emit(AuthDoneState(loading: false));
      },
      (r) {
        Fluttertoast.showToast(msg: r.message);
        _injectUserData(r.user);
        //
        emit(AuthDoneState(loading: false));
        AppRouter.router.pop();
      },
    );
    //
  }

  //
  onAuthSignOutEvent(AuthSignOutEvent event, Emitter<AuthState> emit) async {
    //
    AppRouter.router.go(AppRoutes.authViewsManager.path);

    //
    emit(const AuthLoadingState());
    //
    final response = await _signOutUsecase(request: SignOutRequest());
    //
    response.fold(
      (l) {
        Fluttertoast.showToast(msg: l.message);
        emit(AuthStartState(loading: false, failure: l));
      },
      (r) async {
        Fluttertoast.showToast(msg: r.message);
        emit(const AuthStartState(loading: false, failure: null));
        sl<AuthBloc>().add(const AuthInitializeEvent());
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
