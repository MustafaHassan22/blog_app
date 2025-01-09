part of 'auth_cubit_cubit.dart';

@immutable
sealed class AuthCubitState {}

final class AuthCubitInitial extends AuthCubitState {}

class AuthLoadingStae extends AuthCubitState {}

class AuthSuccesState extends AuthCubitState {
  final User user;

  AuthSuccesState(this.user);
}

class AuthFailureState extends AuthCubitState {
  final String message;

  AuthFailureState(this.message);
}
