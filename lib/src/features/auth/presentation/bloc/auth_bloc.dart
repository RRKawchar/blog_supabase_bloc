import 'package:bloc/bloc.dart';
import 'package:blog_app/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/src/core/common/entities/user_entity.dart';
import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/usecase/use_case.dart';
import 'package:blog_app/src/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_sign_up.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp userSignUp;
  final UserLogin userLogin;
  final CurrentUser currentUser;
  final AppUserCubit appUserCubit;

  AuthBloc({
    required this.userSignUp,
    required this.userLogin,
    required this.currentUser,
    required this.appUserCubit
  })
    : super(AuthInitial()) {
    on<AuthEvent>((_,emit)=>emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_onIsUserLoggedIn);
  }



  void _onIsUserLoggedIn(AuthIsUserLoggedIn even,Emitter<AuthState> emit)async{
   final res= await currentUser(NoParams());
   res.fold((l)=>
       emit(AuthFailure(l.message)),
           (r)=>_emitAuthSuccess(r,emit));

  }

  void _onAuthSignUp(AuthSignUp even,Emitter<AuthState> emit)async{
    final res=await userSignUp(
      UserSignUpParams(
        name: even.name,
        email: even.email,
        password: even.password,
      ),
    );
    print("check res : $res");

    res.fold((failure)=>emit(AuthFailure(failure.message)),
            (userEntity)=>_emitAuthSuccess(userEntity,emit)

    );
  }


  void _onAuthLogin(AuthLogin even,Emitter<AuthState> emit)async{
    final res=await userLogin(
      UserLoginParams(
        email: even.email,
        password: even.password,
      ),
    );
    print("check res : $res");

    res.fold((failure)=>emit(AuthFailure(failure.message)),
            (userEntity)=>_emitAuthSuccess(userEntity,emit)

    );
  }




  void _emitAuthSuccess(UserEntity userEntity,Emitter<AuthState> emit){
    appUserCubit.updateUser(userEntity);
    emit(AuthSuccess(userEntity));
  }



}
