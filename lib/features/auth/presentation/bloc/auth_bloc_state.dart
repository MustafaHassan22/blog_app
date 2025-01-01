part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class AuthSucces extends AuthBlocState {
  final String userId;

  AuthSucces(this.userId);
}

class AuthFailure extends AuthBlocState {
  final String message;

  AuthFailure(this.message);
}
