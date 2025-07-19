

import 'package:blog_app/src/core/common/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_user_state.dart';


class AppUserCubit extends Cubit<AppUserState>{
  AppUserCubit():super(AppUserInitial());

  void updateUser(UserEntity?userEntity){
    if(userEntity==null){
      emit(AppUserInitial());
    }else{
      emit(AppUserLoggedIn(userEntity));
    }
  }

}