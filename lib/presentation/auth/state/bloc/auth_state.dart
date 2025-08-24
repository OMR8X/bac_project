part of 'auth_bloc.dart';

final class AuthState extends Equatable {
  const AuthState({this.failure, this.loading = false});
  final bool loading;
  final Failure? failure;

  AuthState copyWith({Failure? failure, bool loading = false}) {
    return AuthState(failure: failure, loading: loading);
  }

  @override
  List<Object?> get props => [failure, loading];
}

final class AuthLoadingState extends AuthState {
  const AuthLoadingState({super.failure, super.loading = true});
  @override
  List<Object?> get props => [failure, loading];
}

final class AuthStartState extends AuthState {
  const AuthStartState({super.failure, super.loading = false});
  @override
  List<Object?> get props => [failure, loading];
}

final class AuthSigningInState extends AuthState {
  const AuthSigningInState({super.failure, super.loading = false});
  @override
  List<Object?> get props => [failure, loading];
}

final class AuthSigningUpState extends AuthState {
  final List<Section> sections;
  final List<Governorate> governorates;
  const AuthSigningUpState({
    this.sections = const <Section>[],
    this.governorates = const <Governorate>[],
    super.failure,
    super.loading = false,
  });
  @override
  List<Object?> get props => [failure, loading];
}

final class AuthDoneState extends AuthState {
  const AuthDoneState({super.failure, super.loading = false});
  @override
  List<Object?> get props => [failure, loading];
}
