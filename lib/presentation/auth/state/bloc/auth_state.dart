part of 'auth_bloc.dart';

final class AuthenticationState extends Equatable {
  const AuthenticationState({this.failure, this.loading = false, this.successMessage});
  final bool loading;
  final Failure? failure;
  final String? successMessage;

  AuthenticationState copyWith({Failure? failure, bool loading = false, String? successMessage}) {
    return AuthenticationState(failure: failure, loading: loading, successMessage: successMessage);
  }

  @override
  List<Object?> get props => [failure, loading, successMessage];
}

final class AuthLoadingState extends AuthenticationState {
  const AuthLoadingState({super.failure, super.loading = true, super.successMessage});
  @override
  List<Object?> get props => [failure, loading, successMessage];
}

final class AuthStartState extends AuthenticationState {
  const AuthStartState({super.failure, super.loading = false, super.successMessage});
  @override
  List<Object?> get props => [failure, loading, successMessage];
}

final class AuthSigningInState extends AuthenticationState {
  const AuthSigningInState({super.failure, super.loading = false, super.successMessage});
  @override
  List<Object?> get props => [failure, loading, successMessage];
}

final class AuthSigningUpState extends AuthenticationState {
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

final class AuthDoneState extends AuthenticationState {
  const AuthDoneState({super.failure, super.loading = false, super.successMessage});
  @override
  List<Object?> get props => [failure, loading, successMessage];
}
