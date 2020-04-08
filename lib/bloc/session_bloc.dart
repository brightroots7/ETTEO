import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/offline/file_storage.dart';
// import 'package:etteo_demo/offline/file_storage.dart';
import 'package:etteo_demo/providers/authentication_token.dart';
import 'package:etteo_demo/providers/providers.dart';
import './bloc.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AuthenticationProvider authenticationProvider =AuthenticationProvider();
  @override
  SessionState get initialState => InitialSessionState();

  @override
  Stream<SessionState> mapEventToState(
    SessionEvent event,
  ) async* {
    /// Validate the token during intial startup.
    /// Check if token is valid from authentication storage
    /// if so skip the prompt for authenticaiton ,
    /// if access_token is invalid and refresh_token is available ask for renew the token
    /// if renew token fails then prompt for authentication.
    /// if renew token is valid refresh the authentication_token and repersist them.
    if (event is ValidateToken) {
      AuthenticationToken authToken = await AuthenticationToken().readAuthenticationToken();
          

      // check if access token is present
      String accessToken = authToken.getAccessToken();
      if (accessToken == null || accessToken == "") {
        if (await FileStorage().readFile(filename: 'logged.json') == '') {
          AppConfig().loggingFirstTime = true;
        }

        // yield NotAuthenticated();
        yield SessionTokenInValid();
      } else if (authToken != null) {
        /// Check if the token is valid
        bool isValid = authenticationProvider.validateToken(authToken);

        if (isValid) {
          // yield AuthenticationTokenValid();
          yield SessionTokenValid();
        } else {
          /// access token is invalid so trying to renew it.
          try {
            Map map = await authenticationProvider.renewToken(authToken: authToken);  
            AuthenticationToken().loadMap(map);
            yield SessionTokenValid();
          } catch (e) {
            authToken.deletePersistentToken();
            // refresh_token is invalid
            yield SessionTokenInValid();
          }
        }
      }
    }
  }
}
