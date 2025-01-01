import 'package:blogapp/features/auth/domain/use_case/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  final UserSignUp _userSignUp;
  AuthCubitCubit({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthCubitInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingStae());

    final resp = await _userSignUp(
      SignUpParams(email: email, name: name, password: password),
    );
    resp.fold(
      (l) => emit(AuthFailureState(l.message)),
      (r) => emit(AuthSuccesState(r)),
    );
  }
}
