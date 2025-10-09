part of 'auth_bloc.dart';

final class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class AuthInitializeEvent extends AuthenticationEvent {
  const AuthInitializeEvent();

  @override
  List<Object> get props => [];
}

final class AuthStartAuthenticationEvent extends AuthenticationEvent {
  const AuthStartAuthenticationEvent();
  @override
  List<Object> get props => [];
}

final class AuthStartSignInEvent extends AuthenticationEvent {
  const AuthStartSignInEvent();
  @override
  List<Object> get props => [];
}

final class AuthStartSignUpEvent extends AuthenticationEvent {
  const AuthStartSignUpEvent();
  @override
  List<Object> get props => [];
}

final class AuthSignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthSignInEvent({required this.email, required this.password});
  @override
  List<Object> get props => [];
}

final class AuthSignUpEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final int sectionId;
  final int governorateId;
  final String password;

  const AuthSignUpEvent({
    required this.name,
    required this.email,
    required this.sectionId,
    required this.governorateId,
    required this.password,
  });
  @override
  List<Object> get props => [];
}

final class AuthUpdateUserDataEvent extends AuthenticationEvent {
  final String? name;
  final String? email;
  final int? sectionId;
  final int? governorateId;
  final String? password;

  const AuthUpdateUserDataEvent({
    required this.name,
    required this.email,
    required this.governorateId,
    required this.sectionId,
    required this.password,
  });
  @override
  List<Object> get props => [];
}

final class AuthSignOutEvent extends AuthenticationEvent {
  const AuthSignOutEvent();

  @override
  List<Object> get props => [];
}
