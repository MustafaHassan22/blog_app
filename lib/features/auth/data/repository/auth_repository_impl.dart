import 'package:blogapp/core/constant/constant.dart';
import 'package:blogapp/core/error/exceptions.dart';
import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/network/conection_checker.dart';
import 'package:blogapp/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:blogapp/core/common/entitie/user.dart';
import 'package:blogapp/features/auth/data/model/user_modle.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(
    this.authRemoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = authRemoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure('user not logged in!'));
        }
        return right(UserModle(
          id: session.user.id,
          email: session.user.email ?? '',
          name: '',
        ));
      }
      final user = await authRemoteDataSource.getUserCurrentData();
      if (user == null) {
        return left(Failure('user not logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await authRemoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> singupWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
      () async => await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

// rapper func to refactor the same function in the signup ang login
  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constant.noConnectionErrorMessage));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
