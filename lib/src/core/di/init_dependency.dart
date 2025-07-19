
import 'package:blog_app/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/src/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../secrets/app_secrets.dart';

final getIt=GetIt.instance;

Future<void> initDependency()async{

  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );

getIt.registerLazySingleton(()=>Supabase.instance.client);
getIt.registerLazySingleton(()=>AppUserCubit());

_authInit();
  
}


void _authInit(){
  
  getIt.registerFactory<AuthRemoteDataSource>(()=>AuthRemoteDataSourceImpl(getIt()));

  getIt.registerFactory<AuthRepository>(()=>AuthRepositoryImpl(getIt()));
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