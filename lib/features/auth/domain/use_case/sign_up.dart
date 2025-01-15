import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/usecases/usecase.dart';
import 'package:blogapp/core/common/entitie/user.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUpUsecase implements Usecase<User, SignUpParams> {
  final AuthRepo authRepo;

  UserSignUpUsecase(this.authRepo);

  @override
  Future<Either<Failure, User>> call(SignUpParams param) async {
    return await authRepo.singupWithEmailPassword(
      name: param.name,
      email: param.email,
      password: param.password,
    );
  }
}

class SignUpParams {
  final String email;
  final String name;
  final String password;

  SignUpParams({
    required this.email,
    required this.name,
    required this.password,
  });
}
