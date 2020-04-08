class AuthenticationModel {
  final String accessToken;
  final int expiresIn;
  final bool tokenType;
  final String refreshToken;

  AuthenticationModel(
      {this.accessToken, this.expiresIn, this.tokenType, this.refreshToken});

  AuthenticationModel.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        expiresIn = int.parse(json['expires_in'].toString()),
        tokenType = json['token_type'],
        refreshToken = json['refresh_token'];

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'expires_in': expiresIn,
        'token_type': tokenType,
        'refresh_token': refreshToken
      };
}
