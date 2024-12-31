import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/usecases/usecase.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/src/either.dart';

class SignUp implements Usecase<String, SignUpParams> {
  final AuthRepo authRepo;

  SignUp(this.authRepo);

  @override
  Future<Either<Failure, String>> call(SignUpParams param) async {
    return await authRepo.singupWithEmailPassword(
        name: param.name, email: param.email, password: param.password);
  }
}

class SignUpParams {
  final String email;
  final String name;
  final String password;

  SignUpParams(this.email, this.name, this.password);
}
