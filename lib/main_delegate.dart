
// import 'package:background_fetch/background_fetch.dart';
import 'package:etteo_demo/bloc/orders_bloc.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/offline/database/database_client.dart';
import 'package:etteo_demo/pages/login_page.dart';
import 'package:etteo_demo/pages/main_home_page.dart';
import 'package:etteo_demo/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etteo_demo/bloc/bloc.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'offline/sync/sync_queue .dart';



class App extends StatefulWidget {
  const App({Key key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _status = 0;
  


  @override
  void initState() {
    super.initState();
    // initPlatformState();

    /// Initialize the offline sqflite databse
    DatabaseClient().init();
  }

  @override
  void dispose() {
    super.dispose();
    DatabaseClient().close();
  }



  // Future<void> initPlatformState() async {
  //   // Configure BackgroundFetch.
  //   BackgroundFetch.configure(
  //           BackgroundFetchConfig(
  //               minimumFetchInterval: 60,
  //               stopOnTerminate: false,
  //               enableHeadless: true,
  //               forceReload: false),
  //           SyncQueue().checkSyncQueue)
  //       .then((int status) {
  //     print('[BackgroundFetch] SUCCESS: $status');
  //     setState(() {
  //       _status = status;
  //     });
  //   }).catchError((e) {
  //     print('[BackgroundFetch] ERROR: $e');
  //     setState(() {
  //       _status = e;
  //     });
  //   });
  //   if (!mounted) return;
  // }

  @override
  Widget build(BuildContext context) {
    // Initializing the error messasges
    ErrorMessages().loadDefaultErrorMessagesFromAsset('assets/resources/error_messages.json');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  BlocBuilder(
        bloc:  BlocProvider.of<AppSettingsBloc>(context),
         builder: (BuildContext context, AppSettingsState state){
          /// Load splash screen in Appstarted stage.
          if (state is InitialAppSettingsState) {
            return SplashScreen();
          }

          if (state is AppSettingsFetched) {
             AppConfig().setAppSettings(AppSettings());
            return MultiBlocProvider(
              providers: [
                BlocProvider<AuthenticationBloc>(
                    builder: (BuildContext context) => AuthenticationBloc(),
                  ),
                  
                  BlocProvider<SessionBloc>(
                    builder: (context) => SessionBloc(),
                  ),
                  
                  BlocProvider<OrdersBloc>(
                    builder: (context) => OrdersBloc(),
                  ),
                  BlocProvider<LandingBloc>(
                    builder: (context) => LandingBloc(),
                  ),
                  BlocProvider<OfflineBloc>(
                    builder: (BuildContext context) => OfflineBloc(),
                  ),
              ], 
              child: Scaffold(body: IndexPage()),
            );
          }
          if (state is AppSettingsFetchFailed) {
            print('-------------App settings fetch failed---------');

            return fatalError( ErrorMessages().get('connection_offline') + state.error);       
         }

        },
        
      ),
    );
  }
}






class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  SessionBloc _sessionBloc;
  LandingBloc _landingBloc;
  

  @override
  void initState() {
    super.initState();
    _sessionBloc = BlocProvider.of<SessionBloc>(context)..dispatch(ValidateToken());
    _landingBloc = BlocProvider.of<LandingBloc>(context);
  
  }

  @override
  void dispose() {
    super.dispose();
    _sessionBloc?.dispose();
    _landingBloc?.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _sessionBloc,
      builder: (BuildContext context, SessionState state){
       if (state is InitialAuthenticationState) {
            print("state_Splash_main_delegate_$state");
            return SplashScreen();
          }

          if (state is SessionTokenInValid) {
            print("State_login_main_delegate:$state");
            if (AppConfig().isOnline) {
             /// session is invalid and with internet connection.
              return BlocBuilder(
                bloc: _sessionBloc,
                builder: (BuildContext context, SessionState state) {

                  print("State_login__sessionBloc:$state");
                  return LoginPage();
                },
              );
            }else{
              /// session is invalid and with no internet connection, skipping authentication and
              /// allow user to continue work on offline.

              if (AppConfig().userProfile == null) {
                print("state_FetchUserProfile:$state");
                _landingBloc.dispatch(FetchUserProfile());
              }

              return BlocBuilder(
                bloc: _landingBloc,
                builder: (BuildContext context, LandingState state) {
                  print("state_LandingPage:$state");
                  return MainHomePage();
                },
              );
            }
            
          }
        
          if (state is SessionTokenValid) {
           // Fetch user profile
            if (AppConfig().userProfile == null) {
              _landingBloc.dispatch(FetchUserProfile());
            }
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            //   Scaffold.of(context).showSnackBar( progressSnackBarInfo('Fectching data, Please wait...'));
            // });
        
            return BlocBuilder(
              bloc: _landingBloc,
              builder: (BuildContext context, LandingState state) {
                return MainHomePage();
                
              },
            );
          }
          
          
        return SplashScreen();
      },
    );
  }
}





