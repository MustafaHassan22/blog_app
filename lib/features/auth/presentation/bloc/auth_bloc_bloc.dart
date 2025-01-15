import 'package:blogapp/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blogapp/core/common/entitie/user.dart';
import 'package:blogapp/features/auth/domain/use_case/current_user_usecase.dart';
import 'package:blogapp/features/auth/domain/use_case/login_usecase.dart';
import 'package:blogapp/features/auth/domain/use_case/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserSignUpUsecase _userSignUp;
  final LoginUsecase _loginUsecase;
  final CurrentUserUsecase _currentUserUsecase;
  final AppUserCubit _appUserCubit;
  AuthBlocBloc({
    required UserSignUpUsecase userSignUp,
    required LoginUsecase loginUseCase,
    required CurrentUserUsecase currentUserUsecase,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _loginUsecase = loginUseCase,
        _currentUserUsecase = currentUserUsecase,
        _appUserCubit = appUserCubit,
        super(AuthBlocInitial()) {
    //this to do emit loading before every event
    on<AuthBlocEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthLoggedInEvent>(_onUserLoggedIn);
  }

  void _onUserLoggedIn(
      AuthLoggedInEvent event, Emitter<AuthBlocState> emit) async {
    final res = await _currentUserUsecase(NoParam());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSucces(r, emit),
    );
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthBlocState> emit) async {
    final response = await _userSignUp(
      SignUpParams(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => _emitAuthSucces(user, emit),
    );
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthBlocState> emit) async {
    final resp = await _loginUsecase(
      LoginParam(
        email: event.email,
        password: event.password,
      ),
    );
    resp.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSucces(r, emit),
    );
  }

  void _emitAuthSucces(User user, Emitter<AuthBlocState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSucces(user));
  }
}
