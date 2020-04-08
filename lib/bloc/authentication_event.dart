import 'package:flutter/widgets.dart';

@immutable
abstract class AuthenticationEvent {}


class LoggedIn extends AuthenticationEvent{
  final String token;
  LoggedIn({@required this.token});
}

class LoggedInitial extends AuthenticationEvent {}

class Login extends AuthenticationEvent{
  final String username;
  final String password;

  Login({@required this.username, @required this.password});
}


