import 'package:blogapp/core/secrets/app_secrets.dart';
import 'package:blogapp/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:blogapp/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repo.dart';
import 'package:blogapp/features/auth/domain/use_case/login_usecase.dart';
import 'package:blogapp/features/auth/domain/use_case/sign_up.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabse = await Supabase.initialize(
    url: AppSecrets.supabseUrl,
    anonKey: AppSecrets.supabseAnnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabse.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepo>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserSignUpUsecase(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => LoginUsecase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBlocBloc(
        userSignUp: serviceLocator(), loginUseCase: serviceLocator()),
  );
}
