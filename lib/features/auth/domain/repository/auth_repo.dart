import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/common/entitie/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, User>> singupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
