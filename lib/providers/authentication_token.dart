
import 'dart:convert';
import 'dart:io';

import 'package:etteo_demo/offline/file_storage.dart';

enum Token{
 access_token,
  expires_in,
  token_type,
  refresh_token,
  time_of_token,
  time_of_token_expiry
}

class AuthenticationToken{
  static AuthenticationToken _singleton = new AuthenticationToken._internal();

  factory AuthenticationToken() {
    return _singleton;
  }

  AuthenticationToken._internal();

  Map<String, dynamic> token = Map<String, dynamic>();

  AuthenticationToken _loadToken(String tokenJson) {
    Map<String, dynamic> map = json.decode(tokenJson);
    token.addAll(map);
  
    return _singleton;
  }

  AuthenticationToken loadMap(Map map) {
    token.clear();
    token.addAll(map);
    _addExpiredTime();
    _persistAuthenticationToken();
    return _singleton;
  }

  // AuthenticationToken clearMap(){
  //   this.token.clear();
  // }

  /// Calculate the expired time from authentication token, so that it will be used to skip
  /// authentication
  void _addExpiredTime() {
    int seconds = get(Token.expires_in);

    DateTime now = DateTime.now();

    token[splitKey(Token.time_of_token)] = now.toString();
    token[splitKey(Token.time_of_token_expiry)] = now.add(Duration(seconds: seconds - 10)).toString();
        
  }




  /// Getter for all the attribure in authenticaiton token.
  dynamic get(Token key) => token[splitKey(key)];



  /// Getter for access token
  dynamic getAccessToken() {
    return get(Token.access_token);
  }

  /// Getter for refresh token.
  dynamic getRefreshToken() {
    return get(Token.refresh_token);
  }

  /// Check if the token is valid
  bool isValidToken() {
    DateTime tokenValidTime = DateTime.parse(get(Token.time_of_token_expiry));
    return DateTime.now().isBefore(tokenValidTime);
  }

  /// Check if the token is expired
  bool isExpired() {
    DateTime tokenExpiryTime = DateTime.parse(get(Token.time_of_token_expiry));
    return DateTime.now().isAfter(tokenExpiryTime);
  }



  /// Persist authenticatin token. Only when new authentication or renew token.
  void _persistAuthenticationToken() {
    Future<File> file = FileStorage().writeFile(jsonContent: jsonEncode(token));
    print(file);
    // file.then ((onValue) => { print(onValue) ;});
  }

  

  /// Read the authentication token from the app directory
  Future<AuthenticationToken> readAuthenticationToken() async {
    String authFile = await FileStorage().readFile();
    if (authFile == "") {
      return _singleton;
    }
    return _loadToken(authFile);
  }


  // Utility method to split the key from enum string.
  String splitKey(Token key) {
    return key.toString().split('.').last;
  }
 /**
 * Delete the auth token from app directory
 */
  deletePersistentToken() async {
    return await FileStorage().removeFile();
  }


  clear() {
    print("obj this.tokenect_length${ this.token.length}");
    this.token.clear();
  }


}