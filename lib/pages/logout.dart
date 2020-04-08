import 'package:etteo_demo/bloc/bloc.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/main_delegate.dart';
import 'package:etteo_demo/providers/authentication_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "You have logged out",
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                          child: Text(
                        "Thank you for using etteo technician application. we hope to see you soon.",
                        style: Theme.of(context).textTheme.subhead,
                      )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 10,
                        child: OutlineButton(
                          child: new Text(
                            "Login",
                            style: new TextStyle(
                              color: Theme.of(context).brightness == Brightness.light       
                              ? Colors.black
                              : Colors.white,
                              fontSize: 20,
                              fontFamily: 'Roboto'
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.green[300],
                          borderSide: BorderSide(
                            color: Color(0xffa6b2c1), //Color of the border
                            style: BorderStyle.solid, //Style of the border
                            width: 1.0, //width of the border
                          ),
                          onPressed: () {
                           
                            // /AuthenticationToken().clear();
                            AuthenticationToken().deletePersistentToken();
                            AppConfig().userProfile = null;
                            
                            // print("AuthenticationToken().token${AuthenticationToken().deletePersistentToken()}");
                           
                            // AuthenticationToken().loadMap();
                            
                            // print("print_auth_Token${AuthenticationToken().token}");
                            // AuthenticationToken().readAuthenticationToken();

                            // AuthenticationToken authToken;
                            // print("authToken.deletePersistentToken();${authToken.deletePersistentToken()}");
                            // // Redirect to MajorMinor()
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider<AppSettingsBloc>(
                                      builder: (BuildContext context) =>AppSettingsBloc() ..dispatch( FetchAppSettings()),
                                    ),
                                    BlocProvider<NetworkConnectivityBloc>(
                                      builder: (BuildContext context) => NetworkConnectivityBloc()..dispatch(InitNetworkConnectivity()),   
                                    ),
                                  ],
                                  child: App(),
                                )
                              )
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              )
            )
          ),
        ),
      ),
    );

  }
}