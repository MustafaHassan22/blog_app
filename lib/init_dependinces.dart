import 'package:blogapp/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blogapp/core/secrets/app_secrets.dart';
import 'package:blogapp/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:blogapp/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repo.dart';
import 'package:blogapp/features/auth/domain/use_case/current_user_usecase.dart';
import 'package:blogapp/features/auth/domain/use_case/login_usecase.dart';
import 'package:blogapp/features/auth/domain/use_case/sign_up.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:blogapp/features/auth/presentation/cubit/auth_cubit_cubit.dart';
import 'package:blogapp/features/blog/data/data_source/blog_remote_data_source.dart';
import 'package:blogapp/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blogapp/features/blog/domian/repository/blog_repository.dart';
import 'package:blogapp/features/blog/domian/usecases/upload_blog_usecase.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogapp/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabse = await Supabase.initialize(
    url: AppSecrets.supabseUrl,
    anonKey: AppSecrets.supabseAnnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabse.client);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

//register dependencies related to auth feature

void _initAuth() {
  //data source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    //repository
    ..registerFactory<AuthRepo>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    //sign up usecase
    ..registerFactory(
      () => UserSignUpUsecase(serviceLocator()),
    )
    //login usecase
    ..registerFactory(
      () => LoginUsecase(serviceLocator()),
    )
    //current user usecase
    ..registerFactory(() => CurrentUserUsecase(serviceLocator()))
    //auth bloc
    ..registerLazySingleton(
      () => AuthBlocBloc(
        userSignUp: serviceLocator(),
        loginUseCase: serviceLocator(),
        currentUserUsecase: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    )
    //auth cubit
    ..registerLazySingleton(
      () => AuthCubitCubit(
        userSignUp: serviceLocator(),
        loginUsecase: serviceLocator(),
        currentUserUsecase: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

//register dependencies related to blog feature
void _initBlog() {
  //data source
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
      //repository
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(serviceLocator()),
    )
    //usecase
    ..registerFactory(
      () => UploadBlogUsecase(serviceLocator()),
    )
    // blog bloc
    ..registerLazySingleton(
      () => BlogBloc(uploadBlogUsecase: serviceLocator()),
    )
    //blog cubit
    ..registerLazySingleton(
      () => BlogCubit(uploadBlogUsecase: serviceLocator()),
    );
}
