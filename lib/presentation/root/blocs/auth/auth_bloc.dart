import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/resources/errors/failures.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthLoadingState()) {
    //
    on<AuthInitializeEvent>(onAuthInitializeEvent);
    // //
    // on<AuthStartAuthEvent>((event, emit) => emit(const AuthStartState()));
    // //
    // on<AuthStartSignInEvent>((event, emit) => emit(const AuthSigningInState()));
    // on<AuthStartSignUpEvent>((event, emit) => emit(AuthSigningUpState()));
    //
    // on<AuthSignInEvent>(onAuthSignInEvent);
    // on<AuthSignUpEvent>(onAuthSignUpEvent);
    // on<AuthSignOutEvent>(onAuthSignOutEvent);
    // on<AuthUpdateUserDataEvent>(onAuthUpdateUserDataEvent);
    //
  }
  //
  onAuthInitializeEvent(AuthInitializeEvent event, Emitter<AuthState> emit) async {
    //
    emit(const AuthLoadingState());
    //
    await Future.delayed(Durations.extralong4);
    //
    emit(const AuthDoneState());
  }

  //
  // onAuthSignInEvent(AuthSignInEvent event, Emitter<AuthState> emit) async {
  //   // //
  //   // final String email = event.email.trim().toLowerCase();
  //   // final String password = event.password.trim();

  //   // //
  //   // final signUpRequest = SignInRequest(email: email, firebaseToken: await getFirebaseDeviceToken(), password: password);
  //   // //
  //   // emit(const AuthSigningInState(loading: true));
  //   // //
  //   // final response = await _signInUseCase(request: signUpRequest);
  //   // //
  //   // response.fold(
  //   //   (l) {
  //   //     Fluttertoast.showToast(msg: l.message);
  //   //     emit(AuthSigningInState(loading: false, failure: l));
  //   //   },
  //   //   (r) {
  //   //     Fluttertoast.showToast(msg: r.message);
  //   //     emit(const AuthSigningInState(loading: false, failure: null));
  //   //     sl<AuthBloc>().add(const AuthInitializeEvent());
  //   //   },
  //   // );
  //   // //
  // }

  //
  // onAuthSignUpEvent(AuthSignUpEvent event, Emitter<AuthState> emit) async {
  //   //
  //   final String name = event.name.trim();
  //   final String email = event.email.trim().toLowerCase();
  //   final String sectionId = event.sectionId.trim();
  //   final String governorateId = event.governorateId.trim();
  //   final String password = event.password.trim();
  //   //
  //   final signUpRequest = SignUpRequest(name: name, firebaseToken: await getFirebaseDeviceToken(), email: email, sectionId: sectionId, governorateId: governorateId, password: password);
  //   //
  //   emit(const AuthSigningUpState(loading: true));
  //   //
  //   final response = await _signUpUseCase(request: signUpRequest);
  //   //
  //   response.fold(
  //     (l) {
  //       Fluttertoast.showToast(msg: l.message);
  //       emit(AuthSigningUpState(loading: false, failure: l));
  //     },
  //     (r) {
  //       Fluttertoast.showToast(msg: r.message);
  //       emit(const AuthSigningUpState(loading: false, failure: null));
  //       sl<AuthBloc>().add(const AuthInitializeEvent());
  //     },
  //   );
  //   //
  // }

  //
  // onAuthUpdateUserDataEvent(AuthUpdateUserDataEvent event, Emitter<AuthState> emit) async {
  //   //
  //   emit(const AuthLoadingState(loading: true));
  //   //
  //   final String? name = event.name?.trim();
  //   final String? email = event.email?.trim();
  //   final String? governorateId = event.governorateId;
  //   final String? sectionId = event.sectionId;
  //   final String? password = event.password?.trim();
  //   //
  //   final updateUserDataRequest = UpdateUserDataRequest(name: name, email: email, governorateId: governorateId, sectionId: sectionId, password: password);
  //   //
  //   final response = await _updateUserDataUseCase(request: updateUserDataRequest);
  //   //
  //   response.fold(
  //     (l) {
  //       Fluttertoast.showToast(msg: l.message);
  //       emit(AuthDoneState(loading: false));
  //     },
  //     (r) {
  //       Fluttertoast.showToast(msg: r.message);
  //       _injectUserData(r.user);
  //       //
  //       emit(AuthDoneState(loading: false));
  //       AppRouter.router.pop();
  //     },
  //   );
  //   //
  // }

  //
  // onAuthSignOutEvent(AuthSignOutEvent event, Emitter<AuthState> emit) async {
  //   //
  //   AppRouter.router.go(AppRoutes.authViewsManager.path);

  //   //
  //   emit(const AuthLoadingState());
  //   //
  //   await _deleteDeviceTokenUsecase();
  //   //
  //   final response = await _signOutUseCase(request: SignOutRequest());
  //   //
  //   response.fold(
  //     (l) {
  //       Fluttertoast.showToast(msg: l.message);
  //       emit(AuthStartState(loading: false, failure: l));
  //     },
  //     (r) async {
  //       Fluttertoast.showToast(msg: r.message);
  //       emit(const AuthStartState(loading: false, failure: null));
  //       sl<AuthBloc>().add(const AuthInitializeEvent());
  //     },
  //   );
  //   //
  // }

  // Future<void> _injectUserData(UserData data) async {
  //   //
  //   if (sl.isRegistered<UserData>()) {
  //     sl.unregister<UserData>();
  //   }
  //   //
  //   sl.registerSingleton<UserData>(data);

  //   return;
  // }

  // Future<String?> getFirebaseDeviceToken() async {
  //   //
  //   final tokenResponse = await sl<GetDeviceTokenUsecase>().call();
  //   //
  //   return tokenResponse.fold((l) => null, (r) => r);
  // }

  // Future<void> deleteFirebaseDeviceToken() async {
  //   //
  //   final tokenResponse = await sl<GetDeviceTokenUsecase>().call();
  //   //
  //   return tokenResponse.fold((l) => null, (r) => r);
  // }
}
