import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class CurrentUser implements UseCase<UserEntity,NoParams>{

  final AuthRepository authRepository;
  const CurrentUser(this.authRepository);


  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async{
   return await authRepository.currentUser();
  }

}


