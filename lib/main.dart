import 'package:etteo_demo/main_delegate.dart';
import 'package:flutter/material.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  AppConfig().setAppConfig(
    appEnvironment: AppEnvironment.DEV,
    clientSecret: 'kZNw1DsgbevCHGrdWWbUUkKEQnaLjOhm',//'BSOcBKiqoAdQ9oAdmQghsteihAcXBOGj',
    appSettingsUrl: 'https://dev-portal.etteo.com',
    forgotPasswordUrl: 'https://int-auth.etteo.com/Account/Login',
    oneSignalAppId: '9ba52e93-d838-4b84-aebe-d415f7322b58'
  );


  // Default
  AppConfig().setAppSettings(
    AppSettings().loadAppSettingsJson(
      encode({
        "clientId": "etteo.technician",
        "clientRoot": "https://int-portal.etteo.com/",
        "helloSignTestMode": "True",
        "rootApiUrl": "https://int-api.etteo.com/",
        "stsAuthority":"https://int-auth.etteo.com/" //"https://int-auth.etteo.com/"
      })
    )
  );

  BlocSupervisor.delegate = EtteoBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NetworkConnectivityBloc>(
         builder: (BuildContext context) => NetworkConnectivityBloc()..dispatch(InitNetworkConnectivity()),   
        ),
        BlocProvider<AppSettingsBloc>(
          builder: (BuildContext context)=>AppSettingsBloc()..dispatch(FetchAppSettings()),
        ), 
      ],
      child: App(),
    ),
  );
}
