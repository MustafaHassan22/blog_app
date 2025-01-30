part of 'init_dependinces.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabse = await Supabase.initialize(
    url: AppSecrets.supabseUrl,
    anonKey: AppSecrets.supabseAnnonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

//supabase
  serviceLocator.registerLazySingleton(() => supabse.client);

//hive box
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));

  //Internet Connection package
  serviceLocator.registerFactory(() => InternetConnection());

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  // checker internet'
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));
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
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
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
    )
    ..registerFactory<BlogLocakDataSource>(
        () => BlogLocakDataSourceImpl(box: serviceLocator()))
    //repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    //usecase upload blog
    ..registerFactory(
      () => UploadBlogUsecase(serviceLocator()),
    )
    //display blogs
    ..registerFactory(
      () => GetAllBlogsUsecase(serviceLocator()),
    )
    // blog bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlogUsecase: serviceLocator(),
        getAllBlogsUsecase: serviceLocator(),
      ),
    )
    //blog cubit
    ..registerLazySingleton(
      () => BlogCubit(
        uploadBlogUsecase: serviceLocator(),
        getAllBlogsUsecase: serviceLocator(),
      ),
    );
}
