import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:etteo_demo/helpers/helpers.dart';
// import 'package:etteo_mobile/offline/sync/sync_queue.dart';
import './bloc.dart';

class NetworkConnectivityBloc
    extends Bloc<NetworkConnectivityEvent, NetworkConnectivityState> {
  bool networkOfflineOnce = false;
  @override
  NetworkConnectivityState get initialState =>
      InitialNetworkConnectivityState();

  ConnectivityResult connectivityResult;
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  Stream<NetworkConnectivityState> mapEventToState(
    NetworkConnectivityEvent event,
  ) async* {
    if (event is InitNetworkConnectivity) {
      connectivity = Connectivity();
      connectivityResult = await (connectivity.checkConnectivity());
      dispatch(SetNetworkStatus(connectivityResult: connectivityResult));
    }

    if (event is ListenNetworkConnectivity) {
      if (connectivity == null) {
        dispatch(InitNetworkConnectivity());
      }

      _connectivitySubscription = connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        dispatch(SetNetworkStatus(connectivityResult: result));
      });
    }

    if (event is SetNetworkStatus) {
      if (event.connectivityResult == ConnectivityResult.mobile) {
        AppConfig().networkConnectivity = NetworkConnectivity.ONLINE;

        if (networkOfflineOnce) {
          // This will create a post call from queu but does not stop the rending UI.
          // Future(() => {SyncQueue().checkSyncQueueAfterOnline()});
          networkOfflineOnce = false;
        }

        yield NetworkOnline();
        print("Connected => Cellular Network");
      } else if (event.connectivityResult == ConnectivityResult.wifi) {
        AppConfig().networkConnectivity = NetworkConnectivity.ONLINE;

        if (networkOfflineOnce) {
          // This will create a post call from queu but does not stop the rending UI.
          // Future(() => {SyncQueue().checkSyncQueueAfterOnline()});
          networkOfflineOnce = false;
        }

        yield NetworkOnline();
        print("Connected => WiFi");
      } else {
        networkOfflineOnce = true;
        AppConfig().networkConnectivity = NetworkConnectivity.OFFLINE;

        yield NetworkOffline();
        print("Not Connected => Offline , Please Check Internet Connection");
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
