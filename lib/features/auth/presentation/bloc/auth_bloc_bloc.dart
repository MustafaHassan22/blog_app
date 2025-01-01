import 'package:blogapp/features/auth/domain/use_case/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserSignUp _userSignUp;
  AuthBlocBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthBlocInitial()) {
    on<AuthSignUpEvent>((event, emit) async {
      final response = await _userSignUp(
        SignUpParams(
          email: event.email,
          name: event.name,
          password: event.password,
        ),
      );
      response.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthSucces(r)),
      );
    });
  }
}
