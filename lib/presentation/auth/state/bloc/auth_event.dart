part of 'auth_bloc.dart';

final class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthInitializeEvent extends AuthEvent {
  const AuthInitializeEvent();

  @override
  List<Object> get props => [];
}

final class AuthStartAuthEvent extends AuthEvent {
  const AuthStartAuthEvent();
  @override
  List<Object> get props => [];
}

final class AuthStartSignInEvent extends AuthEvent {
  const AuthStartSignInEvent();
  @override
  List<Object> get props => [];
}

final class AuthStartSignUpEvent extends AuthEvent {
  const AuthStartSignUpEvent();
  @override
  List<Object> get props => [];
}

final class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInEvent({required this.email, required this.password});
  @override
  List<Object> get props => [];
}

final class AuthSignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String sectionId;
  final String governorateId;
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

final class AuthUpdateUserDataEvent extends AuthEvent {
  final String? name;
  final String? email;
  final String? sectionId;
  final String? governorateId;
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

final class AuthSignOutEvent extends AuthEvent {
  const AuthSignOutEvent();

  @override
  List<Object> get props => [];
}
