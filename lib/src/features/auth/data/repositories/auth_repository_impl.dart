import 'package:blog_app/src/core/error/exceptions.dart';
import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/services/connection_checker.dart';
import 'package:blog_app/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/src/features/auth/data/models/user_model.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl({required this.authRemoteDataSource,required this.connectionChecker});


  @override
  Future<Either<Failure, UserEntity>> currentUser()async {
    try{

      if(!await (connectionChecker.isConnected)){
       final session= authRemoteDataSource.currentUserSession;
       if(session==null){
         return left(Failure("User not logged in"));
       }

       return right(UserModel(
           id: session.user.id,
           email: session.user.email??"",
           name: "",
       ),);
      }

      final user=await authRemoteDataSource.getCurrentUserData();
      
      if(user==null){
       return left(Failure("User not logged in"));
      }
      return right(user);

    }on ServerException catch(e){
      return left(Failure(e.message));

    }

  }


  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {

    return _getUser(()async=> await authRemoteDataSource.loginWithEmailPassword(
      email: email,
      password: password,
    ));

  }



  Future<Either<Failure, UserEntity>> _getUser(
      Future<UserEntity> Function() fn,
      ) async {
    if(!await (connectionChecker.isConnected)){
      return left(Failure("No Internet connection"));
    }

    try {
      final user = await fn();

      return right(user);
    }on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }


}

