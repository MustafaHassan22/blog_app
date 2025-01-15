import 'package:blogapp/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blogapp/core/common/entitie/user.dart';
import 'package:blogapp/features/auth/domain/use_case/current_user_usecase.dart';
import 'package:blogapp/features/auth/domain/use_case/login_usecase.dart';
import 'package:blogapp/features/auth/domain/use_case/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  final UserSignUpUsecase _userSignUp;
  final LoginUsecase _loginUsecase;
  final CurrentUserUsecase _currentUserUsecase;
  final AppUserCubit _appUserCubit;
  AuthCubitCubit({
    required UserSignUpUsecase userSignUp,
    required LoginUsecase loginUsecase,
    required CurrentUserUsecase currentUserUsecase,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _loginUsecase = loginUsecase,
        _currentUserUsecase = currentUserUsecase,
        _appUserCubit = appUserCubit,
        super(AuthCubitInitial());

//sign up
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

//login
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingStae());
    final res = await _loginUsecase(LoginParam(
      email: email,
      password: password,
    ));
    res.fold(
      (l) => emit(AuthFailureState(l.message)),
      (r) => _emitAuthSucces(r),
    );
  }

  Future<void> checkCurrentUser() async {
    final res = await _currentUserUsecase(NoParam());
    res.fold(
      (l) => emit(AuthFailureState(l.message)),
      (r) => _emitAuthSucces(r),
    );
  }

//refactor emit succes
  void _emitAuthSucces(User user) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccesState(user));
  }
}
