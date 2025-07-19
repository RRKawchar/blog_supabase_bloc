import 'package:flutter/cupertino.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthSignUp({required this.name, required this.email, required this.password});
}


final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({required this.email, required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent {
  const AuthIsUserLoggedIn();
}