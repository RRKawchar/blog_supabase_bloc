import 'package:bloc/bloc.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_sign_up.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp userSignUp;
  final UserLogin userLogin;

  AuthBloc({required this.userSignUp,required this.userLogin})
    : super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }


  void _onAuthSignUp(AuthSignUp even,Emitter<AuthState> emit)async{
    emit(AuthLoading());
    final res=await userSignUp(
      UserSignUpParams(
        name: even.name,
        email: even.email,
        password: even.password,
      ),
    );
    print("check res : $res");

    res.fold((failure)=>emit(AuthFailure(failure.message)),
            (userEntity)=>emit(AuthSuccess(userEntity)));
  }


  void _onAuthLogin(AuthLogin even,Emitter<AuthState> emit)async{
    emit(AuthLoading());
    final res=await userLogin(
      UserLoginParams(
        email: even.email,
        password: even.password,
      ),
    );
    print("check res : $res");

    res.fold((failure)=>emit(AuthFailure(failure.message)),
            (userEntity)=>emit(AuthSuccess(userEntity)));
  }






}
