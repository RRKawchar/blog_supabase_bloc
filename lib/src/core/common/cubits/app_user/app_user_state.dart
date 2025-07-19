
import 'package:blog_app/src/core/common/entities/user_entity.dart';
import 'package:flutter/cupertino.dart';



@immutable
sealed class AppUserState{
 const AppUserState();
}

final class AppUserInitial extends AppUserState{}
final class AppUserLoggedIn extends AppUserState{
 final UserEntity userEntity;
 const AppUserLoggedIn(this.userEntity);
}