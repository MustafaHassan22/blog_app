import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/usecases/usecase.dart';
import 'package:blogapp/features/auth/domain/entitie/user.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/src/either.dart';

class CurrentUserUsecase implements Usecase<User, NoParam> {
  final AuthRepo authRepo;

  CurrentUserUsecase(this.authRepo);

  @override
  Future<Either<Failure, User>> call(NoParam param) async {
    return await authRepo.currentUser();
  }
}

class NoParam {}
