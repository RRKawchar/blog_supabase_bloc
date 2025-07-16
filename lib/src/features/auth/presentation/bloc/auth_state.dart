
import 'package:blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class AuthState{
  const AuthState();
}

final class AuthInitial extends AuthState{}
final class AuthLoading extends AuthState{}
final class AuthSuccess extends AuthState{
  final UserEntity userEntity;
 const AuthSuccess(this.userEntity);
}
final class AuthFailure extends AuthState{
  final String message;
   const AuthFailure(this.message);
}