import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/usecases/usecase.dart';
import 'package:blogapp/core/common/entitie/user.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class LoginUsecase implements Usecase<User, LoginParam> {
  final AuthRepo authRepo;

  LoginUsecase(this.authRepo);
  @override
  Future<Either<Failure, User>> call(LoginParam param) async {
    return await authRepo.loginWithEmailPassword(
      email: param.email,
      password: param.password,
    );
  }
}

class LoginParam {
  final String email;
  final String password;

  LoginParam({
    required this.email,
    required this.password,
  });
}
