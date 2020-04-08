
import 'package:etteo_demo/model/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LandingState {}

class InitialLandingState extends LandingState {}
//shruti
class UserProfileFetchingState extends LandingState {}


class LocalRouteFetching extends LandingState {}

class RouteFetched extends LandingState {
  final List<RouteModel> routes;
  RouteFetched({@required this.routes});
}

class RouteFetching extends LandingState {}

class RouteStatusUpdated extends LandingState {}


class UserProfileFetched extends LandingState {
  final UserProfileModel userProfile;
  UserProfileFetched({@required this.userProfile});
}

class FilteredData extends LandingState {
  final List<RouteModel> routes;
  FilteredData({@required this.routes});
}

class FilteringData  extends LandingState{}


