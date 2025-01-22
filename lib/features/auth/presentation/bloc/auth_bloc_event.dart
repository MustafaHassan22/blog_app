part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

final class AuthSignUpEvent extends AuthBlocEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUpEvent(
    this.name,
    this.email,
    this.password,
  );
}

final class AuthLoginEvent extends AuthBlocEvent {
  final String email;
  final String password;

  AuthLoginEvent(this.email, this.password);
}

final class AuthLoggedInEvent extends AuthBlocEvent {}
