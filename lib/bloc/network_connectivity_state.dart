import 'package:meta/meta.dart';

@immutable
abstract class NetworkConnectivityState {}

class InitialNetworkConnectivityState extends NetworkConnectivityState {}

class NetworkOnline extends NetworkConnectivityState {}

class NetworkOffline extends NetworkConnectivityState {}
