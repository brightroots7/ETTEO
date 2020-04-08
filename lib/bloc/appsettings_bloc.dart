import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/providers/providers.dart';
import './bloc.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
 
  AppSettingsProvider appSettingsProvider = new AppSettingsProvider();
  // OfflineApi _offlineApi = OfflineApi();

  AppSettingsBloc();

  // AppSettingsBloc
  @override
  AppSettingsState get initialState => InitialAppSettingsState();

  @override
  Stream<AppSettingsState> mapEventToState(
    AppSettingsEvent event,
  ) async* {
    // /**
    //    * Fetch App Settings
    //    */
    if (event is FetchAppSettings) {
      await Future.delayed(Duration(seconds: 3), () {});
      // Map appSettings;
      // try {
      //   if (AppConfig().isOnline) {
      //     appSettings = await appSettingsProvider.getAppSettings();
      //   } else {
      //     appSettings = _offlineApi.getAppSettings().toJson();
      //   }

      //   // store model in secure_storage
      //   AppSettings settings = new AppSettings();
      //   settings.loadMap(appSettings);
      yield AppSettingsFetched();

      // } catch (e) {
      //   yield AppSettingsFetchFailed(handleError(e));
      // }
    }

    if (event is FetchAppSettingsInitial) {
      yield InitialAppSettingsState();
    }
  }
}
