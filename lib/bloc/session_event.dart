import 'package:meta/meta.dart';

@immutable
abstract class SessionEvent {}

class ValidateToken extends SessionEvent {}

class RenewToken extends SessionEvent {
  final String refreshToken;

  RenewToken({@required this.refreshToken});
}
