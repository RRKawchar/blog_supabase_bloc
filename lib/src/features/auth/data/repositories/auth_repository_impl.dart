import 'package:blog_app/src/core/error/exceptions.dart';
import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  const AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async{
   try{
  final user=  await authRemoteDataSource.signUpWithEmailPassword(name: name, email: email, password: password);

  return right(user);

   }on ServerException catch(e){
     return left(Failure(e.toString()));
   }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password
  }) async{
    try{
      final user=  await authRemoteDataSource.loginWithEmailPassword(email: email, password: password);

      return right(user);

    }on ServerException catch(e){
      return left(Failure(e.toString()));
    }
  }
}
