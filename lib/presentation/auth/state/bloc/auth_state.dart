part of 'auth_bloc.dart';

final class AuthState extends Equatable {
  const AuthState({this.failure, this.loading = false, this.successMessage});
  final bool loading;
  final Failure? failure;
  final String? successMessage;

  AuthState copyWith({Failure? failure, bool loading = false, String? successMessage}) {
    return AuthState(failure: failure, loading: loading, successMessage: successMessage);
  }

  @override
  List<Object?> get props => [failure, loading, successMessage];
}

final class AuthLoadingState extends AuthState {
  const AuthLoadingState({super.failure, super.loading = true, super.successMessage});
  @override
  List<Object?> get props => [failure, loading, successMessage];
}

final class AuthStartState extends AuthState {
  const AuthStartState({super.failure, super.loading = false, super.successMessage});
  @override
  List<Object?> get props => [failure, loading, successMessage];
}

final class AuthSigningInState extends AuthState {
  const AuthSigningInState({super.failure, super.loading = false, super.successMessage});
  @override
  List<Object?> get props => [failure, loading, successMessage];
}

final class AuthSigningUpState extends AuthState {
  final List<Section> sections;
  final List<Governorate> governorates;
  const AuthSigningUpState({
    this.sections = const <Section>[],
    this.governorates = const <Governorate>[],
    super.failure,
    super.loading = false,
    super.successMessage,
  });
  @override
  List<Object?> get props => [failure, loading, successMessage, sections, governorates];
}

final class AuthDoneState extends AuthState {
  const AuthDoneState({super.failure, super.loading = false, super.successMessage});
  @override
  List<Object?> get props => [failure, loading, successMessage];
}
