import 'package:meta/meta.dart';

@immutable
abstract class SessionState {}

class InitialSessionState extends SessionState {}

class SessionTokenValid extends SessionState {}

class SessionTokenInValid extends SessionState {}
