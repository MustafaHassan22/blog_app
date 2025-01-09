import 'package:blogapp/features/auth/domain/entitie/user.dart';
import 'package:blogapp/features/auth/domain/use_case/login_usecase.dart';
import 'package:blogapp/features/auth/domain/use_case/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserSignUpUsecase _userSignUp;
  final LoginUsecase _loginUsecase;
  AuthBlocBloc(
      {required UserSignUpUsecase userSignUp,
      required LoginUsecase loginUseCase})
      : _userSignUp = userSignUp,
        _loginUsecase = loginUseCase,
        super(AuthBlocInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(
      SignUpParams(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => emit(AuthSucces(user)),
    );
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());
    final resp = await _loginUsecase(
      LoginParam(
        email: event.email,
        password: event.password,
      ),
    );
    resp.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSucces(r)),
    );
  }
}
