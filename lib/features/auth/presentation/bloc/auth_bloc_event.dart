part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

class AuthSignUpEvent extends AuthBlocEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUpEvent(this.name, this.email, this.password);
}
