part of 'auth_cubit_cubit.dart';

@immutable
sealed class AuthCubitState {}

final class AuthCubitInitial extends AuthCubitState {}

class AuthLoadingStae extends AuthCubitState {}

class AuthSuccesState extends AuthCubitState {
  final String userId;

  AuthSuccesState(this.userId);
}

class AuthFailureState extends AuthCubitState {
  final String message;

  AuthFailureState(this.message);
}
