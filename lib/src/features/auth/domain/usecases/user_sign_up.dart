import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/usecase/use_case.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user_entity.dart';

class UserSignUp implements UseCase<UserEntity,UserSignUpParams>{
final AuthRepository authRepository;
const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(UserSignUpParams params) async{
    return await authRepository.signUpWithEmailPassword(name: params.name, email: params.email, password:params.password
    );
  }

}


class UserSignUpParams{
final String name;
final String email;
final String password;
UserSignUpParams({
  required this.name,
  required this.email,
  required this.password,
});
}