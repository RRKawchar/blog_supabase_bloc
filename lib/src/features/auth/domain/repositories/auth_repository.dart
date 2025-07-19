import 'package:blog_app/src/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user_entity.dart';

abstract interface class AuthRepository{
  Future<Either<Failure,UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
});

  Future<Either<Failure,UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  });



  Future<Either<Failure,UserEntity>> currentUser();

}