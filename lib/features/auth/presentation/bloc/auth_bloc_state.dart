part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class AuthSucces extends AuthBlocState {
  final User user;

  AuthSucces(this.user);
}

class AuthFailure extends AuthBlocState {
  final String message;

  AuthFailure(this.message);
}
