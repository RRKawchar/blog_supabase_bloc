
part of 'init_dependency.dart';

final getIt=GetIt.instance;

Future<void> initDependency()async{
  _authInit();
  _blogInit();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.anonKey,
  );

  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;

  getIt.registerLazySingleton(()=>Supabase.instance.client);
  getIt.registerLazySingleton(()=>Hive.box(name:'blogs'));
  getIt.registerFactory<InternetConnectionChecker>(()=>InternetConnectionChecker.instance);
  getIt.registerLazySingleton(()=>AppUserCubit());
  getIt.registerFactory<ConnectionChecker>(()=>ConnectionCheckerImpl(getIt()));


}


void _authInit(){

  getIt.registerFactory<AuthRemoteDataSource>(()=>AuthRemoteDataSourceImpl(getIt()));

  getIt.registerFactory<AuthRepository>(()=>AuthRepositoryImpl(authRemoteDataSource: getIt(),connectionChecker: getIt()));
  getIt.registerFactory(()=>UserSignUp(getIt()));
  getIt.registerFactory(()=>UserLogin(getIt()));
  getIt.registerFactory(()=>CurrentUser(getIt()));

  getIt.registerLazySingleton(()=>AuthBloc(
      userSignUp: getIt(),
      userLogin: getIt(),
      currentUser: getIt(),
      appUserCubit: getIt()
  ));


}


void _blogInit(){

  getIt.registerFactory<BlogRemoteDataSource>(()=>BlogRemoteDateSourceImpl(getIt()));
  getIt.registerFactory<BlogLocalDataSource>(()=>BlogLocalDataSourceImpl(getIt()));

  getIt.registerFactory<BlogRepository>(()=>BlogRepositoryImpl(
      blogRemoteDataSource: getIt(),
      blogLocalDataSource: getIt(),
      connectionChecker: getIt()
  ));
  getIt.registerFactory(()=>UploadBlogUseCase(getIt()));
  getIt.registerFactory(()=>GetBlogUseCase(getIt()));
  getIt.registerLazySingleton(()=>BlogBloc(
      uploadBlogUseCase:  getIt(),
      getBlogUseCase: getIt()

  ));


}