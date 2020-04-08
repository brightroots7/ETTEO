import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/helpers/date_helper.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/model/models.dart';
import 'package:etteo_demo/bloc/bloc.dart';
import 'package:etteo_demo/offline/sync/sync_queue%20.dart';
import 'package:etteo_demo/providers/providers.dart';
import 'package:etteo_demo/providers/route-sync-util.dart';

import 'package:etteo_demo/providers/user_profile_provider.dart';
import 'package:intl/intl.dart';
import 'bloc.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  List<RouteModel> routeList = List();
  List<RouteModel> listitems = new List();
  List<RouteModel> filterlistitems = new List();

  List<RouteStatusModel> routeStatus = new List();

  static DateTime serviceDate = DateTime.now();
  var date = DateFormat("EEEE, MMMM d").format(serviceDate).toUpperCase();

   var searchFieldFlag = true;

  setDate(DateTime dateTime) {
    date = DateFormat("EEEE, MMMM d").format(dateTime).toUpperCase();
  }

   //this method will filterOut listItem from the List
  void dataFiltering(String text) {
    var searchedText = text;
    
    //if searchedValue is null,then it will set the filterlistitems list Empty
    if (searchedText.length == 0) {
      filterlistitems.clear();
      // listItem.add(listitems);
      return;
    }
    filterlistitems.clear();
    filterlistitems = listitems.where((data) {
      return data.marketName.toLowerCase().startsWith(searchedText.toLowerCase());
    }).toList();

    // listItem.add(filterlistitems);
  }

  List<RouteModel> _searchResult = new List();

  // void marketFilter(String text){
  //    var searchedText = text;
  //     _searchResult.clear();
  //     if (searchedText.isEmpty) {
      
  //     return;
  //   }

  //   routeList.forEach((data) {
  //     if (data.marketName.toLowerCase().startsWith(searchedText.toLowerCase()))
  //      print("searched true");
  //      return _searchResult.add(data);
  //   });

   
  // }



  sortRouteByTime(List<RouteModel> routes) {
    routes?.sort((a, b) => a.order.service?.compareTo(b.order.service));
  }
  

  final RouteProvider routeProvider = RouteProvider();
  // final DocumentsProvider documentsProvider = DocumentsProvider();
  final UserProfileProvider _userProfileProvider = UserProfileProvider();

  @override
  LandingState get initialState => InitialLandingState();

  @override
  Stream<LandingState> mapEventToState( LandingEvent event) async* { 
     if (event is FetchRoute) {
      if (!AppConfig().isOnline) {
        dispatch(FetchLocalRoute());
        return;
      }
      yield RouteFetching();
      routeList = await routeProvider.getAllRoutes( serviceDate: getDateAlone(serviceDate));
      print("LandingBloc routeList online or offline :$routeList");
        
      RouteSyncUtil.shared.updateRouteForDate(
          routes: routeList, date: getDateAlone(serviceDate));

      // Turn off this so that the variable is not utilized after one time usage.
      if (AppConfig().isUserLoggedInFirstTime) {
        AppConfig().loggingFirstTime = false;
      }
      sortRouteByTime(routeList);
      yield RouteFetched(routes: routeList);
    }

    if (event is FetchRouteStatus) {
      routeStatus = await routeProvider.getRouteStatusOffline();
    }

    if (event is FetchLocalRoute) {
      yield LocalRouteFetching();
      routeList = await routeProvider
          .getRoutesForServiceDate(getDateAlone(serviceDate));
      sortRouteByTime(routeList);
      yield RouteFetched(routes: routeList);
    }
    
    if (event is MoveServiceDatePreviousDay) {
      yield RouteFetching();
      serviceDate = serviceDate.subtract(Duration(days: 1));
      setDate(serviceDate);
      dispatch(AppConfig().isOnline ? FetchRoute() : FetchLocalRoute());
      // dispatch(FetchLocalRoute());
    }

     if (event is MoveServiceDateToToday) {
      yield RouteFetching();
      serviceDate = DateTime.now();
      setDate(serviceDate);
      dispatch(AppConfig().isOnline ? FetchRoute() : FetchLocalRoute());
      // dispatch(FetchLocalRoute());
    }

    if (event is SetServiceDateAsToday) {
      serviceDate = DateTime.now();
      setDate(serviceDate);
    }

     if (event is MoveServiceDateToNextDay) {
      yield RouteFetching();
      serviceDate = serviceDate.add(Duration(days: 1));
      setDate(serviceDate);
      dispatch(AppConfig().isOnline ? FetchRoute() : FetchLocalRoute());
      // dispatch(FetchLocalRoute());
    }


     if (event is MoveServiceDateSpecificDay) {
      serviceDate = DateTime.parse(event.routePublishedDate);
      setDate(serviceDate);
      dispatch(FetchLocalRoute());
    }


    if (event is RefreshRoutesDisplayedOnPublishedDate) {
      if (compareDay(serviceDate.toString(), event.routePublishedDate)) {
        dispatch(FetchLocalRoute());
      }
    }


    if (event is FetchLocalRouteForToday) {
      serviceDate = DateTime.now();
      setDate(serviceDate);
      dispatch(FetchLocalRoute());
    }


    if (event is UpdateRouteStatus) {
      await routeProvider.updateRouteStatus(
          routeId: event.routeId, routeModel: event.routeStatusModel);
      if (AppConfig().isOnline) {
        // This will create a post call from queu but does not stop the rending UI.
        Future(() => {SyncQueue().checkSyncQueueAfterOnline()});
      }
    }

    if (event is UpdateRoute) {
      await routeProvider.updateRouteOffline(event.routeModel);
    }



    if (event is FetchUserProfile) {
      yield UserProfileFetchingState();
      UserProfileModel userProfileModel = await _userProfileProvider.getUserProfile();

      // Setting it to global config.
      AppConfig().userProfile = userProfileModel;
     
      // yield UserProfileFetched(userProfile: userProfileModel);
    }


    
  }
}
