import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/usecase/use_case.dart';
import 'package:blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/auth_repository.dart';

class UserLogin implements UseCase<UserEntity,UserLoginParams>{
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(UserLoginParams params) async{
    return await authRepository.loginWithEmailPassword(email: params.email, password:params.password
    );
  }


}


class UserLoginParams{
  final String email;
  final String password;

  const UserLoginParams({required this.email,required this.password});
}