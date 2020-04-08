

import 'package:etteo_demo/providers/authentication_provider.dart';
import 'package:etteo_demo/bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/providers/providers.dart';
import 'package:etteo_demo/helpers/helpers.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent ,AuthenticationState>{
  final AuthenticationProvider authenticationProvider = new AuthenticationProvider();

  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
    if(event is Login){
      yield Authenticating();
      try{
        Map map = await authenticationProvider.authenticate(
          username: event.username, 
          password: event.password
        );

        /// Load the token and persist in auth storage
        AuthenticationToken().loadMap(map);
          // Adding this to identify logged in for the first time and pull all the routes and order for that day.
        if (AppConfig().isUserLoggedInFirstTime) {
          String content = encode({'logged_on': DateTime.now().toUtc().toString()});
              
          // FileStorage() .writeFile(filename: 'logged.json', jsonContent: content);
             
        }
        yield Authenticated(token:  AuthenticationToken().token.toString());
        
      }catch(e){
         print(e);
      }
    }

  }
  
  checkAccessRevoked(e) {
    if (e?.response?.data['error_description'] == 'user is not a resource') {}
  }

  
}