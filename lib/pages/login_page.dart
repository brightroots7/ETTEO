import 'package:etteo_demo/bloc/bloc.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/pages/main_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailAddressController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

   _onLoginButtonPressed() {
      if (this._formKey.currentState.validate()) {
        _formKey.currentState.save();
        _authenticationBloc.dispatch(Login(
          username: _emailAddressController.text,
          password: _passwordController.text,
        ));
        print("------------------lO");
      }
    }

    return BlocListener(
      bloc: _authenticationBloc,
      listener: (BuildContext context, AuthenticationState state){
        if (state is AuthenticationFailed) {
          print('Authentication failed from bloc progressSnackBarError:$state');
          Scaffold.of(context).showSnackBar(progressSnackBarError('${state.error}'));   
        }

        if (state is AuthenticationAccessRevoked) {
          print('Authentication Access Revoked progressSnackBarError:$state');
          Scaffold.of(context).showSnackBar(progressSnackBarError('Access denied. Please contact administrator.'));   
        }

        if (state is Authenticating) {
          print('Authenticating_progressSnackBarInfo :$state');
          Scaffold.of(context).showSnackBar( progressSnackBarInfo('Authenticating, Please wait...'));
          
             
        }
        if (state is Authenticated) {
          print('Authenticated_hideCurrentSnackBar :$state');
          Scaffold.of(context).hideCurrentSnackBar();
          // showDialogBox(context,state.token );
           
        }
        print('FInal State :$state');
      },
      child:BlocBuilder(
        bloc: _authenticationBloc,
        builder:  (BuildContext context, AuthenticationState state){
         
          if (state is Authenticated) {
            if (AppConfig().userProfile == null) {
              BlocProvider.of<LandingBloc>(context)
                ..dispatch(FetchUserProfile());
            }
           
            return MainHomePage();

          }
         

          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints.expand(height: 225),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/logo_transp.bg.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height:30),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.mail_outline,
                              color: Color(0xff4682b4),
                            ), // icon is 48px widget.
                          ),
                          hintText: 'Email',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              borderSide: BorderSide(color: Color(0xff4682b4))),
                          ),
                          validator: (value) {
                          if (value.isEmpty) {
                            return 'Username cannot be empty';
                          }
                          return null;
                        },
                        controller: _emailAddressController,
                      ),
                      SizedBox(height:24),
                      TextFormField(
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.lock_outline,
                              color: Color(0xff4682b4),
                            ), // icon is 48px widget.
                          ),
                          hintText: 'Password',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Color(0xff4682b4))),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                        controller: _passwordController,
                      ),
                      SizedBox(height:10),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () {
                            _onLoginButtonPressed();
                          },
                          padding: EdgeInsets.all(10),
                          color: Color(0xff4682b4),
                          child: Text('Sign-In',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              letterSpacing: 3,
                              color: Colors.white)),
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.black54, fontFamily: 'Roboto'),
                        ),
                        
                        onPressed: () {
                           _forgotPassURL();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );



        },
      )
      
      
     
    );
  }
}


_forgotPassURL() async {
  String url = AppConfig().forgotPasswordUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


