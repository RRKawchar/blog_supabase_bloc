import 'package:bloc/bloc.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_sign_up.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp})
    : _userSignUp = userSignUp,
      super(AuthInitial()) {
    on<AuthSignUp>((even, emit)async {
     final res=await _userSignUp(
        UserSignUpParams(
          name: even.name,
          email: even.email,
          password: even.password,
        ),
      );

     res.fold((failure)=>emit(AuthFailure(failure.message)), (uid)=>emit(AuthSuccess(uid)));
    });
  }
}
