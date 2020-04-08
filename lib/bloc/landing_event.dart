
import 'package:etteo_demo/model/models.dart';
import 'package:meta/meta.dart';

// @immutable
// abstract class LandingEvent {}


// class FetchUserProfile extends LandingEvent {}


@immutable
abstract class LandingEvent {}

class FetchLocalRoute extends LandingEvent {}

class FetchUserProfile extends LandingEvent {}

class FetchRoute extends LandingEvent {}

class FetchRouteStatus extends LandingEvent {}

class UpdateRoute extends LandingEvent {
  final RouteModel routeModel;
  UpdateRoute({@required this.routeModel});
}

class UpdateRouteStatus extends LandingEvent {
  final RouteStatusModel routeStatusModel;
  final String routeId;

  UpdateRouteStatus({@required this.routeId, @required this.routeStatusModel});
}

class MoveServiceDatePreviousDay extends LandingEvent {}

class MoveServiceDateToNextDay extends LandingEvent {}

class MoveServiceDateToToday extends LandingEvent {}

class MoveServiceDateSpecificDay extends LandingEvent {
  final String routePublishedDate;
  MoveServiceDateSpecificDay({@required this.routePublishedDate});
}

class RefreshRoutesDisplayedOnPublishedDate extends LandingEvent {
  final String routePublishedDate;
  RefreshRoutesDisplayedOnPublishedDate({@required this.routePublishedDate});
}

class SetServiceDateAsToday extends LandingEvent {}

class FetchLocalRouteForToday extends LandingEvent {}


class DataFilter extends LandingEvent{
  final String searchText;
  DataFilter({@required this.searchText});
}



