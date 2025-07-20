
import 'package:blog_app/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/src/core/services/connection_checker.dart';
import 'package:blog_app/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/src/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/src/features/home/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/src/features/home/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/src/features/home/domain/repositories/blog_repository.dart';
import 'package:blog_app/src/features/home/domain/usecases/blog_usecase.dart';
import 'package:blog_app/src/features/home/domain/usecases/get_blog_usecase.dart';
import 'package:blog_app/src/features/home/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../secrets/app_secrets.dart';

final getIt=GetIt.instance;

Future<void> initDependency()async{
  _authInit();
  _blogInit();
  
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );

getIt.registerLazySingleton(()=>Supabase.instance.client);
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

  getIt.registerFactory<BlogRepository>(()=>BlogRepositoryImpl(getIt()));
  getIt.registerFactory(()=>UploadBlogUseCase(getIt()));
  getIt.registerFactory(()=>GetBlogUseCase(getIt()));
  getIt.registerLazySingleton(()=>BlogBloc(
      uploadBlogUseCase:  getIt(),
      getBlogUseCase: getIt()

  ));


}