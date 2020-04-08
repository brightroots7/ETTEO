import 'package:etteo_demo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:etteo_demo/providers/providers.dart';

class AuthenticationProvider{
  final AuthenticationApi authenticationApi  = new AuthenticationApi();

  //Authenticate the user

  Future<Map> authenticate({@required String username, @required String password}){
    return authenticationApi.authenticate(username: username, password: password);
  }

  // Validate the authentication token
  bool validateToken(AuthenticationToken  authToken){
    return authToken.isValidToken();
  }

  /// Renew the access token.
  Future<Map> renewToken({@required AuthenticationToken authToken}) {
    return authenticationApi.renewToken(authToken: authToken);
  }

}