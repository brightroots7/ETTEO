import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NetworkConnectivityEvent {}

class InitNetworkConnectivity extends NetworkConnectivityEvent {}

class ListenNetworkConnectivity extends NetworkConnectivityEvent {}

class SetNetworkStatus extends NetworkConnectivityEvent {
  final ConnectivityResult connectivityResult;
  SetNetworkStatus({@required this.connectivityResult});
}
