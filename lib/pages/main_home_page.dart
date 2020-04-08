import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:etteo_demo/bloc/bloc.dart';
import 'package:etteo_demo/bloc/orders_bloc.dart';
import 'package:etteo_demo/bloc/orders_event.dart';
import 'package:etteo_demo/bloc/orders_state.dart';
// import 'package:etteo_demo/bloc/off';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/pages/logout.dart';

import 'package:etteo_demo/pages/start_service_page.dart';
import 'package:etteo_demo/pages/widgets/order/route_list.dart';
import 'package:etteo_demo/pages/widgets/settings/settings.dart';
import 'package:etteo_demo/providers/providers.dart';
// import 'package:etteo_demo/widgets/shared/check_updates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:etteo_demo/model/models.dart';




class MainHomePage extends StatefulWidget {
  // final UserProfileModel userProfile;
  // MainHomePage(this.userProfile);
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  var resultDate ;
  LandingBloc _landingBloc;
  OfflineBloc _offlineBloc;
  Completer<void> _refreshCompleter;
  OrdersBloc _ordersBloc;

  StreamSubscription offlineBlocSubscription;

  bool showInitializingWidget = true;
  bool enableControls = true;
  
  @override
  void initState() { 
   
    resultDate = DateTime.now();
    _landingBloc = BlocProvider.of<LandingBloc>(context);
   _offlineBloc = BlocProvider.of<OfflineBloc>(context);    
    _ordersBloc = BlocProvider.of<OrdersBloc>(context);
    // _offlineBloc = BlocProvider.of<OfflineBloc>(context);
    super.initState();
   if (AppConfig().isUserLoggedInFirstTime) {
      _landingBloc.setDate(DateTime.now());
      _landingBloc.dispatch(SetServiceDateAsToday());
    }
    
    _refreshCompleter = Completer<void>();
    initData();
  }






  void initData() {
    _offlineBloc.dispatch(CheckMasterTableUpdate());
    _offlineBloc.dispatch(SyncOfflineQueue());

    offlineBlocSubscription = _offlineBloc.state.listen((s) {
      if (s is CheckMasterTableUpdate) {
        setState(() {
          enableControls = false;
        });
      }

      if (s is SyncAllMasterDataCompleted) {
        setState(() {
          showInitializingWidget = false;
          enableControls = true;
          
        });
        

        if (AppConfig().isOnline) {
          _landingBloc = BlocProvider.of<LandingBloc>(context)
            ..dispatch(FetchRouteStatus())
            ..dispatch(FetchRoute());
        } else {
          _landingBloc = BlocProvider.of<LandingBloc>(context)
            ..dispatch(FetchRouteStatus())
            ..dispatch(FetchLocalRoute());
        }
      }

      if (s is DeleteAllOfflineDataCompleted) {
        // /**
        //  * Stops the push notificaiton for this device.
        //  */

        // EtteoNotification.shared.stopNotification();
        Navigator.popUntil(context, ModalRoute.withName('/'));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LogoutPage()),
        );
      }
    });
  }















  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(),
        bottomSheet: showInitializingWidget ? CheckUpdates() : null,
      body: bodyWidget(),
      drawer: getDrawer()
    );
 
  }



  Widget buildDrawer() {
    Widget drawer;
    print("getDrwar called${AppConfig().isOnline } ${AppConfig().userProfile} ");
    if (AppConfig().isOnline != null && AppConfig().userProfile != null) {
       print("checkkkkkkk111111111 called");
      drawer = BlocBuilder(
          // bloc: _landingBloc..dispatch(FetchUserProfile()),
          bloc: _landingBloc,
          builder: (BuildContext context, LandingState state) {
            if (state is UserProfileFetched) {
              return BlocProvider.value(
                value: _offlineBloc,
                child: DrawerWidget(state.userProfile),
              );
             
            }

            print("state is UserProfileFetched other state:$state");
            print("AppConfig().userProfileeeeeeeee:${AppConfig().userProfile}");
           
            return BlocProvider.value(
              value: _offlineBloc..dispatch(GetOfflineQueueData()),
              child: DrawerWidget(AppConfig().userProfile),
            );
            // return DrawerWidget(AppConfig().userProfile);
          });
    } 
    else if (AppConfig().isOnline != null && AppConfig().userProfile != null) {
      print("check222222 called");
      drawer = BlocProvider.value(
        value: _offlineBloc..dispatch(GetOfflineQueueData()),
        child: DrawerWidget(AppConfig().userProfile),
      );
    } 
    else {
      drawer = null;
    }
    return drawer;
  }




  

   Widget getDrawer() {
    Widget drawer;
      print("getDrwar called${AppConfig().isOnline } ${AppConfig().userProfile} ");
    if (AppConfig().isOnline != null && AppConfig().userProfile != null) {
      print("checkkkkkkk111111111 called");
      drawer = BlocBuilder(
        // bloc: _landingBloc..dispatch(FetchUserProfile()),
        bloc: _landingBloc,
        builder: (BuildContext context, LandingState state) {
          if (state is UserProfileFetched) {
              print("DrawerWidget(AppConfig().userProfile) UserProfileFetched:${state.userProfile.fullName}");
            print("UserProfileFetched");
            return BlocProvider.value(
              value: _offlineBloc,
              child: DrawerWidget(state.userProfile),
            );
            
            // return DrawerWidget(state.userProfile);
          }
          print("DrawerWidget(AppConfig().userProfile):${AppConfig().userProfile.fullName}");
          print("Landing bloc other state:$state");
          return BlocProvider.value(
            value: _offlineBloc..dispatch(GetOfflineQueueData()),
            child: DrawerWidget(AppConfig().userProfile),
          );
          // return DrawerWidget(AppConfig().userProfile);
        }
      );
    } 
    else if (AppConfig().isOnline != null &&
      AppConfig().userProfile != null) {
        print("check222222 called");
      drawer = BlocProvider.value(
        value: _offlineBloc..dispatch(GetOfflineQueueData()),
        child: DrawerWidget(AppConfig().userProfile),
      );
    } 
    else {
      drawer = null;
    }
    return drawer;
  }




  AppBar appBarWidget(){
    return  AppBar(
      elevation: 1.0,
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/logo.png', width: 200, height: 50),
      ),
      iconTheme: new IconThemeData(color: Colors.black),
      actions: <Widget>[
         //if searcFieldFlag is true it will show the searchfield.
        //  _ordersBloc.searchFieldFlag == true ?
        AppConfig().isOnline?
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchPage(ordersBloc: _ordersBloc,)));
          },
        )
         :Container() 
      ],
      centerTitle: true,
    );
  }


  Widget bodyWidget(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(screenAwareSize(15, 30, context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          datePart(context),
          Expanded(
            child: BlocListener(
              bloc: _landingBloc,
              listener:  (BuildContext context, LandingState state) {
                if (state is InitialLandingState) {}

                if (state is RouteFetched) {
                  setState(() {
                    enableControls = true;
                  });
                  // Scaffold.of(context).showBodyScrim(false, 0.0);
                }

                _refreshCompleter?.complete();
                _refreshCompleter = Completer();

              },
              child: BlocBuilder(
                bloc: _landingBloc,
                builder: (BuildContext context, LandingState state) {
                  if (state is InitialLandingState) {}

                  if (state is LocalRouteFetching) {
                    return showSpinner();
                  }

                  if (state is RouteFetching) {
                    // Scaffold.of(context).showBodyScrim(true, 1);
                    return showSpinner();
                  }

                  if (state is RouteFetched) {
                    print("state.routes:${state.routes}");

                    return RefreshIndicator(
                      onRefresh: (){
                        _landingBloc.dispatch( AppConfig().isOnline? FetchRoute() : FetchLocalRoute());
                        
                        return _refreshCompleter.future;
                      }, 
                      child: state.routes.isNotEmpty
                      ?Container(
                        child: BlocProvider.value(
                          value: _landingBloc,
                           child: 
                            //  buildBodyWidget()
                            // Center(
                            //   child: Text("routes assigned this date"),
                            // ),
                           RoutingList(routes: state.routes),                  
                          ),
                        )
                      :
                      // RoutingList(routes: state.routes), 
                      // buildBodyWidget()
                      Container(
                        child: Center(
                          child: Text("No Routes assigned on this date."),
                        ),
                      )
                    );
                  }
                  return Container();
                }
              ),
            )
          )
        ],
      ),
    );
  }





  //Date part 
  Padding datePart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Text(
                _landingBloc.date,
                //textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: screenAwareSize(13, 26, context),
                    color: Colors.black54),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: 50,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  alignment: Alignment.center,
                  color: Colors.black54,
                  onPressed: enableControls
                      ? () {
                          _landingBloc.dispatch(MoveServiceDatePreviousDay());
                          setState(() {
                            enableControls = false;
                          });
                        }
                      : () {},
                ),
              ),
              InkWell(
                focusColor: Colors.blue,
                child: Text(
                  'Today',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: screenAwareSize(30, 60, context),
                      fontWeight: FontWeight.bold),
                ),
                onTap: enableControls
                    ? () {
                        _landingBloc.dispatch(FetchLocalRouteForToday());
                        setState(() {
                          enableControls = false;
                        });
                      }
                    : () {},
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  alignment: Alignment.center,
                  color: Colors.black54,
                  onPressed: enableControls
                      ? () {
                          _landingBloc.dispatch(MoveServiceDateToNextDay());
                          setState(() {
                            enableControls = false;
                          });
                        }
                      : () {},
                ),
              )
            ],
          )
        ],
      ),
    );
  }


  Widget buildBodyWidget(){
   final size = MediaQuery.of(context).size;
   Future.delayed(const Duration(seconds: 3), () {
      if (this.mounted) {
       setState(() {});
      }
   });

   return Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0,left: 10,right: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[



                // Align(
                //     alignment: Alignment.center,
                //     child: Text(
                //       DateFormat('EEEE,MMMM d').format(resultDate).toString().toUpperCase(),
                //       style: TextStyle(
                //           fontSize: 20,
                //           color: Colors.black54),
                //     )),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: <Widget>[
                //     SizedBox(
                //       width: 50,
                //       child: IconButton(
                //         icon: Icon(Icons.arrow_back_ios),
                //         alignment: Alignment.center,
                //         color: Colors.black54,
                //         onPressed:  () {
                //           setState(() {
                //             resultDate = resultDate.subtract(Duration(days: 1));
                //           });
                //         }   
                //       ),
                //     ),
                //     InkWell(
                //       focusColor: Colors.blue,
                //       child: Text(
                //         'Today',
                //         style: TextStyle(
                //             fontSize: 30,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       onTap:(){
                //        setState(() {
                //          resultDate = DateTime.now();
                //        });
                //       }    
                //     ),
                //     SizedBox(
                //       width: 50,
                //       child: IconButton(
                //         icon: Icon(Icons.arrow_forward_ios),
                //         alignment: Alignment.center,
                //         color: Colors.black54,
                //         onPressed: (){
                          
                //           setState(() {
                //             resultDate = resultDate.add(Duration(days: 1));
                //           });
                //         }  
                //       ),
                //     )
                //   ],
                // ),
                // datePart(context),
                SizedBox(height: MediaQuery.of(context).size.height/60,),
                Container(
                  height: MediaQuery.of(context).size.height/1.6,
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                               Text("AH8J37D",style: TextStyle(color: Colors.black54,fontSize: size.height/40),),
                               Text("OPEN",style: TextStyle(color: Colors.black54,fontSize: size.height/40)),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/90,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("American Home Shield",style: TextStyle(color: Colors.black,fontSize: size.height/40,fontWeight: FontWeight.w400)),
                                Text("09832402",style: TextStyle(color: Colors.black,fontSize: size.height/45,fontWeight: FontWeight.w300)),
                              ],
                            ),
                           SizedBox(height: MediaQuery.of(context).size.height/90,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Text("Initial Service Call",style: TextStyle(color: Colors.black,fontSize: size.height/40,fontWeight: FontWeight.bold),),
                               Text("8AM - 9AM",style: TextStyle(color: Colors.black54,fontSize: size.height/40)),
                             ],
                           ),
                           SizedBox(height: MediaQuery.of(context).size.height/80,),
                            
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Line Items",style: TextStyle(color: Colors.black87,fontSize: size.height/45,fontWeight: FontWeight.w400)),
                                Text("1.Clogged Sink",style: TextStyle(color: Colors.black87,fontSize: size.height/50,fontWeight: FontWeight.w300)),
                                Text("2.Faucet Leaking",style: TextStyle(color: Colors.black87,fontSize: size.height/50,fontWeight: FontWeight.w300)),
                                Text("3.Toilet Running",style: TextStyle(color: Colors.black87,fontSize: size.height/50,fontWeight: FontWeight.w300)),
                              ],
                            ),
                          
                           SizedBox(height: MediaQuery.of(context).size.height/90,),
                            Text("Flags",style: TextStyle(color: Colors.black,fontSize: size.height/45,fontWeight: FontWeight.bold),),
                            Row(
                              children: <Widget>[
                                Icon(Icons.outlined_flag,size: size.height/30,),
                                Text("   Must collect a service fee",style: TextStyle(color: Colors.black87,fontSize: size.height/50,fontWeight: FontWeight.w300)),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/90,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Customer",style: TextStyle(color: Colors.black,fontSize: size.height/45,fontWeight: FontWeight.bold),),
                                Text("John Patric",style: TextStyle(color: Colors.black87,fontSize: size.height/50,fontWeight: FontWeight.w400)),
                                Text("161 Kimball Bridge Rd",style: TextStyle(color: Colors.black87,fontSize: size.height/50,fontWeight: FontWeight.w300)),
                                Text("Apharetta, GA 30009",style: TextStyle(color: Colors.black87,fontSize: size.height/50,fontWeight: FontWeight.w300)),
                                
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/90,),
                            Row(
                              children: <Widget>[
                               PopupMenuButton<int>(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 919876543210,
                                      child: Text(
                                        "+919876543210",
                                        style: TextStyle(
                                        color: Colors.black, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 911234567890,
                                      child: Text(
                                        "+911234567890",
                                        style: TextStyle(
                                            color: Colors.black ,fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 916789054321,
                                      child: Text(
                                        "+916789054321",
                                        style: TextStyle(
                                            color: Colors.black, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                  onSelected: (value) async{
                                    print("value:$value"); 
                                     String phoneNumber = 'tel:+$value';
                                    try {
                                      await launch(phoneNumber);
                                    } catch (e) {
                                      throw 'Could not make a call';
                                    }
                                      
                                  },
                                  child: CircleAvatar(
                                    radius: MediaQuery.of(context).size.height/50,
                                    child: Icon(Icons.call,size: size.height/32,)
                                    
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width/20,),
                                CircleAvatar(
                                  radius: MediaQuery.of(context).size.height/50,
                                  child: InkWell(
                                    child: Icon(Icons.map,size: size.height/32,),
                                    onTap: (){
                                      openMaps(context);
                                    },
                                  )
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/50,),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment:Alignment.center,
                              child: Material(
                                borderRadius: BorderRadius.circular(30),
                                shadowColor: Colors.grey,
                                elevation:2,
                                color: Colors.white,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> StartServicePage()));
                                  },
                                  child: Container(
                                    width:MediaQuery.of(context).size.width/2.3,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 2),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment:Alignment.center,
                                    height: MediaQuery.of(context).size.height/20,
                                    child:  Text("Start Service", style: TextStyle(color:Colors.black87,
                                    fontSize: MediaQuery.of(context).size.height/40,fontWeight: FontWeight.w400),),
                                  ),
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BottomNavigationTabBar()));
                      // bloc Query for all
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
 




  openMaps(BuildContext context) async {
    try {
      final title = "Current location";
      final description = "Current";
      // final coords = Coords(31.233568, 121.505504);
      final availableMaps = await MapLauncher.installedMaps;

       Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
         print(position);
        final coords = Coords(position.latitude, position.longitude);

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                       ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                          description: description,
                        ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
               
  }
}











class DrawerWidget extends StatefulWidget {
  final UserProfileModel userProfile;
  DrawerWidget(this.userProfile);
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
bool enableControls = true;
  OfflineBloc _offlineBloc;
  int queueCount = 0;
  StreamSubscription offlineSubscription;



   @override
  void initState() {
    super.initState();
    _offlineBloc = BlocProvider.of<OfflineBloc>(context);
    offlineSubscription = _offlineBloc.state.listen((s) {
      if (s is OfflineQueueDataFetched) {
        setState(() {
          queueCount = s.count;
           print("Count Queue:$queueCount");
        });
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    offlineSubscription?.cancel();
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(checkNull(this.widget.userProfile?.fullName),
                   style: Theme.of(context).textTheme.headline
                  ), 
                  accountEmail: Text(checkNull(this.widget.userProfile?.emailAddress),
                    style: Theme.of(context).textTheme.subhead
                  ),
                  currentAccountPicture: this.widget.userProfile?.profileImage == null
                    ? Image.asset('assets/images/account_circle.png',color: Colors.black)
                    : SizedBox(
                      width: 64,
                      height: 64,
                      child: CachedNetworkImage(
                        imageUrl: this.widget.userProfile?.profileImage,
                        useOldImageOnUrlChange: true,
                        placeholder: (context, url) => Image.asset('assets/images/account_circle.png',color: Colors.black),
                        errorWidget: (context, url, error) =>const Icon(Icons.error),     
                      ),
                    ),
                  
                  decoration: BoxDecoration(color: Colors.white),
                ),
                new ListTile(
                  leading: Icon(FontAwesomeIcons.database),
                  title: Text("Queue"),
                  trailing: Text('$queueCount',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),  
                  onTap: enableControls
                  ?() {
                   Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: _offlineBloc,
                          child: QueuePage()
                          // OfflineQueue(),
                        )
                      ),
                    );
                  
                  } 
                  :() {}    
                ),
                new Divider(),
                new ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: enableControls

                  ?(){
                    Navigator.of(context).push(
                     MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                          value: _offlineBloc,
                          child: Settings(),
                        )
                      ),
                    );
                  } 
                  : () {},   
                ),
                new Divider(),
                new ListTile(
                    leading: Icon(Icons.help),
                    title: Text("Help"),
                    onTap: () {
                      _launchURL();
                    }),
                new Divider(),
                new ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: new Text("Sign-Out"),
                  onTap: enableControls
                  ?(){
                    _offlineBloc.dispatch(DeleteAllOfflineData());
                    AuthenticationToken().token.clear();
                    // print("print_auth_Token${AuthenticationToken().token}");

                    _offlineBloc.state.listen((state) => {
                      if (state is DeleteAllOfflineDataCompleted)
                        {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => LogoutPage()),
                          )
                        }
                    });





                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //   builder: (context) => LogoutPage()
                    //   ),
                    // );
                  }
                  :(){}
                ),
              ],
            ),
          ),
          Container(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTile(
                      enabled: false,
                      title:FutureBuilder(
                        future: getVersionNumber(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>Row(
                          children: <Widget>[
                            Text("Version"),
                            SizedBox(width: 10,),
                            Text(
                              snapshot.hasData ? snapshot.data : "Loading ...",
                              style: TextStyle(color: Colors.black38),
                            ),
                          ],
                        )
                      ),
                      trailing: NetworkStatusIndicator(),
                    
                    ),
                  
                  ],
                )
              )
            )
          )
        ],
      ),
    );
  }
}


class NetworkStatusIndicator extends StatefulWidget {
  const NetworkStatusIndicator();

  @override
  _NetworkStatusColorIndicatorState createState() =>
      _NetworkStatusColorIndicatorState();
}

class _NetworkStatusColorIndicatorState extends State<NetworkStatusIndicator> {
  NetworkConnectivityBloc _networkConnectivityBloc;
  @override
  void initState() {
    _networkConnectivityBloc =
        BlocProvider.of<NetworkConnectivityBloc>(context);
    _networkConnectivityBloc.dispatch(InitNetworkConnectivity());
    _networkConnectivityBloc.dispatch(ListenNetworkConnectivity());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _networkConnectivityBloc,
      builder: (BuildContext context, NetworkConnectivityState state) {
        if (state is NetworkOnline) {
          return showNetworkStatus(Colors.green);
        }
        if (state is NetworkOffline) {
          return showNetworkStatus(Colors.red);
        }
        return showNetworkStatus(Colors.grey);
      },
    );
  }
}


Widget showNetworkStatus(MaterialColor color) {
  return IconButton(
    icon: Icon(
      Icons.fiber_manual_record,
      color: color,
      size: 15,
    ),
    onPressed: () {},
  );
}





Future<String> getVersionNumber() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

_launchURL() async {
  const url = 'https://portal.etteo.com/knowledge-base';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}





//Check Updates widget

class CheckUpdates extends StatefulWidget {
  CheckUpdates();

  _CheckUpdatesState createState() => _CheckUpdatesState();
}

class _CheckUpdatesState extends State<CheckUpdates> {
  OfflineBloc _offlineBloc;
  String progressText = '';

  List<String> initializingTexts = <String>[
    'Initializing',
    'Starting the van',
    'Loading the truck'
  ];

  String intializingTextSuffix = ', Please wait...';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _offlineBloc,
        builder: (BuildContext context, OfflineState state) {
          return Wrap(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Icon(
                    Icons.local_shipping,
                    size: 75,
                    color: Colors.blue,
                  ))),
              // Padding(
              //     padding: EdgeInsets.all(20),
              Center(
                  child: SpinKitThreeBounce(
                color: Colors.blue,
                size: 20,
              )),
              // ),
              // child: Image.asset('assets/images/services.png',
              //     width: screenAwareSize(100, 500, context)))),
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    initializingTexts[
                            Random().nextInt(initializingTexts.length)] +
                        intializingTextSuffix,
                  ),
                ),
              ),
            ],
          );
        });
  }
}







class SearchPage extends StatefulWidget {
  final OrdersBloc ordersBloc;

  const SearchPage({Key key, this.ordersBloc}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  final SpeechToText speech = SpeechToText();
  // OrdersBloc _ordersBloc;
  bool _hasSpeech = false;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";

   @override
  void initState() {
    super.initState();
    initSpeechState();
    // widget.ordersBloc = BlocProvider.of<OrdersBloc>(context);
    
  }
  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(onError: errorListener, onStatus: statusListener );

    if (!mounted) return;
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }


   void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords} - ${result.finalResult}";
      print("lastWordsssssss:$lastWords");
      print("result.recognizedWords:${result.recognizedWords}");
      widget.ordersBloc.dispatch(OrdersSearch(searchText: result.recognizedWords));

    });
  }

  void errorListener(SpeechRecognitionError error ) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }
  void statusListener(String status ) {
    setState(() {
      lastStatus = "$status";
    });
  }

  @override
  void dispose() {
    // widget.ordersBloc.dispose();
    super.dispose();
   widget.ordersBloc.state.listen((s) {
     if(s is OrdersFetched){
       s.orders.clear();
     }
   });

  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Navigator.of(context).pop();
          }
         ),
        backgroundColor: Colors.white,
        title: Text("Search",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top:20, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
             //  height: MediaQuery.of(context).size.height/15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),   
                color: Colors.grey[100],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Material(
                  color: Colors.grey[100],
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.search,color: Colors.grey),
                      Expanded(
                        child: TextField(
                          // textAlign: TextAlign.center,
                          decoration: InputDecoration.collapsed(
                            hintText: ' Search by customer name or address',
                          ),
                          onChanged: (text) {
                            // text = lastWords;
                            

                            widget.ordersBloc.dispatch(OrdersSearch(searchText: text));
                          },
                        ),
                      ),
                      InkWell(
                        child: Icon(Icons.mic,color: Colors.grey,),
                        onTap: () {
                          lastWords = "";
                          lastError = "";
                          speech.listen(onResult: resultListener ).then((onValue){
                            print("onValue onValue onValue onValue onValue:$onValue");
                          });
                          
                          setState(() {
                            
                          });
                        },
                      )
                    ],
                  ),
                ),
              )
            ) ,
            new Expanded(
              child: BlocBuilder<OrdersBloc, OrdersState>(
                bloc: widget.ordersBloc,
                builder: (context, event){
                    if(event is OrdersSearched){
                      if(event.orders.length>0){
                         return new ListView.builder(
                          itemCount: event.orders.length,
                          itemBuilder: (context, i) {
                            return new Card(
                              child: new ListTile(
                              
                                title: new Text(event.orders[i].customerName),
                              ),
                              // margin: const EdgeInsets.all(0.0),
                            );
                          },
                        );
                      }else{
                        return Center(
                          child: Text("not found\nMake sure that all words are spelled correctly"),
                        );
                      }
                     
                    }
                    if(event is OrdersSearching ){
                      return showSpinner();
                    }
                    return  Container();
                  }
                )
             
            ),
          ],
        ),
      ),
    );
  }
}



class QueuePage extends StatefulWidget {
  @override
  _QueuePageState createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Navigator.of(context).pop();
          }
         ),
        backgroundColor: Colors.white,
        title: Text("Queue",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
     floatingActionButton: FloatingActionButton.extended(
      icon: Icon(Icons.sync),
        onPressed: () { }, label: Text('Sync'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Navigator.of(context).pop();
          }
         ),
        backgroundColor: Colors.white,
        title: Text("Settings",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top:15, left: 8, right:8),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5,
              child: ListTile(
                title: Text("Sync Master Data"),
                subtitle: Text("Synchroize data from the ETTEO Portal"),
                isThreeLine: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}









class BottomNavigationTabBar extends StatefulWidget {
 @override
 BottomNavigationTabBarState createState() => new BottomNavigationTabBarState();
}
 
class BottomNavigationTabBarState extends State<BottomNavigationTabBar> with SingleTickerProviderStateMixin {
 TabController controller;
 
 @override
 void initState() {
   controller = new TabController(length: 5, vsync: this);
   super.initState();
 }
 
 @override
 void dispose() {
    controller.dispose();
    super.dispose();
  }
 
 @override
 Widget build(BuildContext context) {
  return 
     new Scaffold(
      // drawer: new LeftMenu(),
      body: new TabBarView(
      controller: controller,
      children: <Widget>[
          new GeneralInfoPage(),
          new ServicesPage(),
          new PartsPage(),
          new DocumentsPage(),
          new NotePage()
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 10,
        child: new TabBar(
          controller: controller,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.blueGrey,
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.info_outline),
            ),
            new Tab(
              icon: new Icon(Icons.home),
            ),
            new Tab(
              icon: new Icon(Icons.settings),
            ),
             new Tab(
              icon: new Icon(Icons.image),
            ),
             new Tab(
              icon: new Icon(Icons.event_note),
            ),
          ],
        ),
      ), 
    );
  }
}

class GeneralInfoPage extends StatefulWidget {
  @override
  _GeneralInfoPageState createState() => _GeneralInfoPageState();
}

class _GeneralInfoPageState extends State<GeneralInfoPage> {
  @override
  Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.blueGrey,),
          onPressed: (){
            Navigator.of(context).pop();
          }
         ),
        backgroundColor: Colors.white,
        title: Text("General Information",
         style: TextStyle(
           color: Colors.black,fontWeight: 
           FontWeight.w400
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0,left: 10,right: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                'Order # A74HC86',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                  ),
                )
              ),
             SizedBox(height: MediaQuery.of(context).size.height/60,),
             Text('Customer',style: TextStyle(fontSize:  size.height/39),),
             Container(
               height:MediaQuery.of(context).size.height/3.2,
               width: MediaQuery.of(context).size.width,
               child: Card(
                 elevation: 5,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Text('Name',
                         style:TextStyle(
                           fontWeight:FontWeight.w400,
                           fontSize: size.height/45,
                           color: Colors.black
                          )
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/80,),
                       Row(
                         children: <Widget>[
                           Icon(Icons.person,color: Colors.blueGrey,),
                           SizedBox(width: MediaQuery.of(context).size.height/80,),
                           Text('John Patric',
                             style:TextStyle(
                               fontWeight:FontWeight.w400,
                               fontSize: size.height/50,
                               color: Colors.black
                              )
                            ),
                          ],
                        ),
                       SizedBox(height: MediaQuery.of(context).size.height/80,),
                       Text('Phone Number',style:TextStyle(fontWeight:FontWeight.w400,fontSize: size.height/45,color: Colors.black)),
                       SizedBox(height: MediaQuery.of(context).size.height/80,),
                       Row(
                         children: <Widget>[
                           Icon(Icons.phone_android,color:Colors.blueGrey),
                           SizedBox(width: MediaQuery.of(context).size.height/80,),
                           Column(
                             children: <Widget>[
                               Text('123-038-9283',style:TextStyle(fontWeight:FontWeight.w300,fontSize: size.height/50,color: Colors.black)),
                               Text('123-038-9283',style:TextStyle(fontWeight:FontWeight.w300,fontSize: size.height/50,color: Colors.black)),
                             ],
                           )
                         ],
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height/100,),
                       Text('Address',style:TextStyle(fontWeight:FontWeight.w400,fontSize: size.height/45,color: Colors.black)),
                       SizedBox(height: MediaQuery.of(context).size.height/80,),
                       Row(
                         children: <Widget>[
                           Icon(Icons.location_on,color:Colors.blueGrey),
                           SizedBox(width: MediaQuery.of(context).size.height/80,),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Text('161 Kimball Bridge Rd',
                                  style:TextStyle(
                                    fontWeight:FontWeight.w300,
                                    fontSize: size.height/50,
                                    color: Colors.black
                                  )
                                ),
                               Text('Alphartta, GA 30009',style:TextStyle(fontWeight:FontWeight.w300,fontSize: size.height/50,color: Colors.black)),
                             ],
                           )
                         ],
                       ),
                     ],
                   ),
                 ),
               ),
             ),
             SizedBox(
               height: MediaQuery.of(context).size.height/60,
              ),
             Text('Flags',style: TextStyle(fontSize: 20),),
             Container(
               height: MediaQuery.of(context).size.height/15,
               child: Card(
                 elevation: 5,
                 child: Row(
                    children: <Widget>[
                      Icon(Icons.outlined_flag,color:Colors.black),
                      SizedBox(width: MediaQuery.of(context).size.height/80,),
                      Text('Water Heater Haul Away',
                       style:TextStyle(
                         fontWeight:FontWeight.w300,
                         fontSize: 16,color: Colors.black
                        )
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/60,),
              Text('General Information',style: TextStyle(fontSize: 20),),
              Container(
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Line of Business",
                             style: TextStyle(
                               fontWeight:FontWeight.w400,
                               fontSize: size.height/45,
                               color: Colors.black
                              )
                            ),
                            Text("Open",
                             style: TextStyle(
                               fontWeight:FontWeight.w400,
                               fontSize: size.height/45,
                               color: Colors.black
                              )
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/80,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.settings,color: Colors.blueGrey,),
                            SizedBox(width: MediaQuery.of(context).size.height/80,),
                            Text('Plumbing',
                             style:TextStyle(
                               fontWeight:FontWeight.w300,
                               fontSize: size.height/50,
                               color: Colors.black
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/80,),
                        Text("Source",style: TextStyle(fontWeight:FontWeight.w400,fontSize: size.height/45,color: Colors.black)),
                        SizedBox(height: MediaQuery.of(context).size.height/80,),
                         Row(
                          children: <Widget>[
                            Icon(Icons.person,color: Colors.blueGrey,),
                            SizedBox(width: MediaQuery.of(context).size.height/80,),
                            Text('First American',style:TextStyle(fontWeight:FontWeight.w300,fontSize: size.height/50,color: Colors.black)),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/80,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.event_note,color: Colors.blueGrey,),
                            SizedBox(width: MediaQuery.of(context).size.height/80,),
                            Text('09734892',style:TextStyle(fontWeight:FontWeight.w300,fontSize: size.height/50,color: Colors.black)),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/80,),
                        Text("Owner",style: TextStyle(fontWeight:FontWeight.w400,fontSize: size.height/45,color: Colors.black)),
                        SizedBox(height: MediaQuery.of(context).size.height/80,),
                         Row(
                          children: <Widget>[
                            Icon(Icons.person,color: Colors.blueGrey,),
                            SizedBox(width: MediaQuery.of(context).size.height/80,),
                            Text('Circa Service',style:TextStyle(fontWeight:FontWeight.w300,fontSize: size.height/50,color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]
          ),
        )
      )
    );
  }
}

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.blueGrey,),
          onPressed: (){
            Navigator.of(context).pop();
          }
         ),
        backgroundColor: Colors.white,
        title: Text("Services",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top:20,left: 8,right: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(" Initial Service Call",
                style: TextStyle(color: Colors.black,fontSize: size.height/35,fontWeight: FontWeight.bold),
              ), 
             Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0, left: 8,right:8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text("Service Provider",style: TextStyle(fontSize:size.height/50,fontWeight: FontWeight.bold),),
                              // SizedBox(height:MediaQuery.of(context).size.height/200),
                              Text("Circa Service",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/55),),
                              Text("Line of Business",style: TextStyle(fontSize:size.height/50,fontWeight: FontWeight.bold),),
                              Text("Plumbing",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/55),),
                              Text("Schelued Time",style: TextStyle(fontSize:size.height/50,fontWeight: FontWeight.bold),),
                              Text("8am-9am",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/55),),
                            ],
                          ),
                          SizedBox(width:MediaQuery.of(context).size.width/3.9),
                          Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text("Technician",style: TextStyle(fontSize:size.height/55,fontWeight: FontWeight.bold),),
                              Text("john Smith",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              Text("Schelued Date",style: TextStyle(fontSize:size.height/55,fontWeight: FontWeight.bold),),
                              Text("2019-06-07",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              Text("Completed Date",style: TextStyle(fontSize:size.height/55,fontWeight: FontWeight.bold),),
                              Text("--",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(height:MediaQuery.of(context).size.height/100),
                      Text("Line Items",
                      style: TextStyle(color: Colors.black,fontSize: size.height/35,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height:MediaQuery.of(context).size.height/95),
                      Text("1.Clogged Sink",style: TextStyle(color: Colors.black,fontSize: size.height/50,fontWeight: FontWeight.w400)),
                      SizedBox(height:MediaQuery.of(context).size.height/95),
                      Row(
                      children: <Widget>[
                        Text("Status",style: TextStyle(fontSize: size.height/55,fontWeight: FontWeight.bold),),
                        SizedBox(width:MediaQuery.of(context).size.width/60),
                        Text("Assigned",style: TextStyle(fontSize:size.height/55,color: Colors.blue),)
                        ],
                      ),
                      SizedBox(height:MediaQuery.of(context).size.height/95),
                      Text("Description",style: TextStyle(fontSize:size.height/55,fontWeight: FontWeight.bold),),
                      SizedBox(height:MediaQuery.of(context).size.height/200),
                      Text("Example of a service description. Lorem lpsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor",
                      style: TextStyle(fontSize:size.height/60),),
                      SizedBox(height:MediaQuery.of(context).size.height/95),
                      Row(
                      children: <Widget>[
                        Text("Parts Required",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                          SizedBox(width:MediaQuery.of(context).size.width/60),
                          Text("Yes",style: TextStyle(fontSize:size.height/60,),),
                        
                        ],
                      ),
                      Divider(color: Colors.black,),
                      Text("2.Faucet Leaking",style: TextStyle(fontSize:size.height/50,fontWeight: FontWeight.w400)),
                      SizedBox(height:MediaQuery.of(context).size.height/100),
                      Row(
                      children: <Widget>[
                        Text("Status",style: TextStyle(fontSize:size.height/55,fontWeight: FontWeight.bold),),
                          SizedBox(width:MediaQuery.of(context).size.width/60),
                        Text("Assigned",style: TextStyle(fontSize:size.height/55,color: Colors.blue),)
                        ],
                      ),
                      SizedBox(height:MediaQuery.of(context).size.height/95),
                      Text("Description",style: TextStyle(fontSize:size.height/55,fontWeight: FontWeight.bold),),
                      SizedBox(height:MediaQuery.of(context).size.height/200),
                      Text("Example of a service description. Lorem lpsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                      style: TextStyle(fontSize:size.height/60),),
                      SizedBox(height:MediaQuery.of(context).size.height/95),
                      Row(
                      children: <Widget>[
                        Text("Parts Required",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                          SizedBox(width:MediaQuery.of(context).size.width/60),
                          Text("No",style: TextStyle(fontSize:size.height/60,),),
                        ],
                      ),
                      Divider(color: Colors.black,),
                      Text("3.Toilet Running",style: TextStyle(fontSize:size.height/50,fontWeight: FontWeight.w400)),
                      SizedBox(height:MediaQuery.of(context).size.height/95),
                      Row(
                      children: <Widget>[
                        Text("Status",style: TextStyle(fontSize:size.height/55,fontWeight: FontWeight.bold),),
                          SizedBox(width:MediaQuery.of(context).size.width/60),
                        Text("Assigned",style: TextStyle(fontSize:size.height/55,color: Colors.blue),)
                        ],
                      ),
                      SizedBox(height:MediaQuery.of(context).size.height/95),
                      Text("Description",style: TextStyle(fontSize:size.height/55,fontWeight: FontWeight.bold),),
                      SizedBox(height:MediaQuery.of(context).size.height/200),
                      Text("Example of a service description. Lorem lpsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor",
                      style: TextStyle(fontSize:size.height/60),),
                      SizedBox(height:MediaQuery.of(context).size.height/90),
                      Row(
                      children: <Widget>[
                        Text("Parts Required",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                          SizedBox(width:MediaQuery.of(context).size.width/60),
                          Text("No",style: TextStyle(fontSize:size.height/60,),),
                        ],
                      ),
                      SizedBox(height:MediaQuery.of(context).size.height/50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}

class PartsPage extends StatefulWidget {
  @override
  _PartsPageState createState() => _PartsPageState();
}

class _PartsPageState extends State<PartsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
     backgroundColor: Colors.white,
       appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.blueGrey,),
          onPressed: (){
            Navigator.of(context).pop();
          }
         ),
        backgroundColor: Colors.white,
        title: Text("Parts",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height/1.3,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top:10,left: 8,right: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(" Initial Service Call",
               style: TextStyle(color: Colors.black,fontSize: size.height/35,fontWeight: FontWeight.bold),
              ),
             Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0, left: 8,right:8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Line Items",
                      style: TextStyle(color: Colors.black,fontSize: size.height/40,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height:MediaQuery.of(context).size.height/150),
                      Text("1.Clogged Sink",style: TextStyle(fontSize: size.height/45,fontWeight: FontWeight.w400)),
                      SizedBox(height:MediaQuery.of(context).size.height/150),
                      Text("Existing Customer Unit",style: TextStyle(fontSize: size.height/50,fontWeight: FontWeight.w300),),
                      SizedBox(height:MediaQuery.of(context).size.height/150),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text("Make",style: TextStyle(fontSize: size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              SizedBox(height:MediaQuery.of(context).size.height/200),
                              Text("Serial Number",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                            
                            ],
                          ),
                          SizedBox(width:MediaQuery.of(context).size.width/3.9),
                          Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text("Model",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              SizedBox(height:MediaQuery.of(context).size.height/200),
                              Text("Age",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              
                            ],
                          ),
                        ],
                      ),
                    Divider(color: Colors.black,),
                    
                      Text("Requested Part",style: TextStyle(fontSize: size.height/50,fontWeight: FontWeight.w300),),
                      SizedBox(height:MediaQuery.of(context).size.height/100),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text("Make",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              SizedBox(height:MediaQuery.of(context).size.height/200),
                              Text("Serial Number",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              SizedBox(height:MediaQuery.of(context).size.height/200),
                              Text("Quantity",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                            
                            ],
                          ),
                          SizedBox(width:MediaQuery.of(context).size.width/3.9),
                          Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text("Model",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              SizedBox(height:MediaQuery.of(context).size.height/200),
                              Text("Description",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                            
                              
                            ],
                          ),
                        ],
                      ),
                    Divider(color: Colors.black,),
                    //  SizedBox(height:MediaQuery.of(context).size.height/100),
                      Text("Vendor",style: TextStyle(fontSize: size.height/50,fontWeight: FontWeight.w300),),
                      SizedBox(height:MediaQuery.of(context).size.height/100),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text("Name",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              SizedBox(height:MediaQuery.of(context).size.height/200),
                              Text("SKU",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                            
                            ],
                          ),
                           SizedBox(width:MediaQuery.of(context).size.width/3.5),
                          Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text("Phone Number",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                            
                            ],
                          ),
                        ],
                      ),
                      Divider(color: Colors.black,),
                      // SizedBox(height:MediaQuery.of(context).size.height/100),
                      Text("Delivery & Pickup",style: TextStyle(fontSize: size.height/50,fontWeight: FontWeight.w300),),
                      SizedBox(height:MediaQuery.of(context).size.height/100),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text("Delivery Date",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              SizedBox(height:MediaQuery.of(context).size.height/200),
                              Text("Pickup Date",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              SizedBox(height:MediaQuery.of(context).size.height/200),
                              Text("Tracking Number",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              
                            ],
                          ),
                          SizedBox(width:MediaQuery.of(context).size.width/4.5),
                          Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text("Delivery Address",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              SizedBox(height:MediaQuery.of(context).size.height/200),
                              Text("Pickup Address",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              SizedBox(height:MediaQuery.of(context).size.height/200),
                              Text("Internal PO#",style: TextStyle(fontSize:size.height/60,fontWeight: FontWeight.bold),),
                              Text("Lorem lpsum",style: TextStyle(fontWeight:FontWeight.w300,color: Colors.black,fontSize: size.height/60),),
                              
                            ],
                          ),
                        ],
                      ),
                    SizedBox(height:MediaQuery.of(context).size.height/50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}

class DocumentsPage extends StatefulWidget {
  @override
  _DocumentsPageState createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.blueGrey,),
          onPressed: (){
            Navigator.of(context).pop();
          }
         ),
        backgroundColor: Colors.white,
        title: Text("Documents",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: Container(
                    height: MediaQuery.of(context).size.height/11,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            color: Colors.red,
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/30,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Site Photo",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("Water Heater"),
                              Text(DateFormat('MM-dd-yyyy HH:mm a').format(DateTime.now()).toString())
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddDocuments()));
        },
        child: Icon(Icons.add), 
      ),
    );
  }
}






class AddDocuments extends StatefulWidget {
  @override
  _AddDocumentsState createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
  String _dropDownValue;
  File _image;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.blueGrey,),
          onPressed: (){
            Navigator.of(context).pop();
          }
         ),
        backgroundColor: Colors.white,
        title: Text("Add Document",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right:10,top:8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/1.6,
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 Text("Type",style: TextStyle(fontSize:size.height/45)),
                 SizedBox( height: MediaQuery.of(context).size.height/80,),
                  Container(
                    padding:  const EdgeInsets.all(5.0),
                    height: MediaQuery.of(context).size.height/17,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                    ),
                    child: DropdownButton(
                      underline: Container(),
                     hint: _dropDownValue == null
                      ? Text('Select Value')
                      : Text(
                          _dropDownValue,
                          style: TextStyle(color: Colors.blue),
                        ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.blue),
                      items: [' Select One', ' Select Two', ' Select Three'].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            _dropDownValue = val;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox( height: MediaQuery.of(context).size.height/50,),
                  Text("Description",style: TextStyle(fontSize:size.height/45)),
                  SizedBox( height: MediaQuery.of(context).size.height/80,),
                   Container(
                      alignment: Alignment.topLeft,
                      // width: MediaQuery.of(context).size.width/1.2,
                      height: MediaQuery.of(context).size.height/5,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey,width: 1)
                      ) ,
                      child: TextField(
                        maxLines: 5,
                        // controller: explainTextController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          hintText: "Enter desription",
                           hintStyle: TextStyle(fontSize: size.height/50),
                          border: InputBorder.none
                        ),
                        onChanged: (val){
                           setState(() {
                            //  explainText = val;
                           });
                        },
                      ),
                    ),
                    SizedBox( height: MediaQuery.of(context).size.height/50,),
                    Container(
                      alignment: Alignment.center,
                      width:MediaQuery.of(context).size.width,
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        shadowColor: Colors.grey,
                        elevation:5,
                        color: Colors.white,
                        child: InkWell(
                          onTap: ()async{
                            var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                              if(image != null){
                                setState(() {
                                _image = image;
                              });
                              }
                          },
                          child: Container(
                            width:MediaQuery.of(context).size.width/1.5,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey,width: 1),
                              borderRadius: BorderRadius.circular(5),
                              
                              image: _image!=null? DecorationImage(
                                image: FileImage(_image),
                                fit: BoxFit.cover
                              ):null,
                            ),
                        
                            alignment:Alignment.center,
                              height: MediaQuery.of(context).size.height/8,
                            child: _image == null ?Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.camera_alt,color: Colors.blueGrey,),
                                Text("Capture/Upload Photo",style: TextStyle(color: Colors.blueGrey),)
                              ],
                            ) 
                            :Container()
                          ),
                        ),
                      )
                    ),
                    SizedBox( height: MediaQuery.of(context).size.height/40,),
                    Row(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height/25,
                          width:  MediaQuery.of(context).size.width/3.5,
                          decoration: BoxDecoration(
                             border: Border.all(color: Colors.black,width: 1),

                          ),
                          child: InkWell(
                            onTap: (){},
                            child: Container(
                              alignment: Alignment.center,
                              child: Text("CANCEL"),
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/20,),
                        Container(
                          height: MediaQuery.of(context).size.height/25,
                          width:  MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black,width: 1),
                          ),
                          child: InkWell(
                            onTap: (){},
                            child: Container(
                              color: Colors.blue,
                              alignment: Alignment.center,
                              child: Text("UPLOAD",style: TextStyle(color:Colors.white),)
                            ),
                          ),
                        )
                      ],
                    )
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.blueGrey,),
          onPressed: (){
            Navigator.of(context).pop();
          }
         ),
        backgroundColor: Colors.white,
        title: Text("Notes",style: TextStyle(color: Colors.black),),
        centerTitle: true,
       
      ),
      body:Container(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: Container(
                    
                    height: MediaQuery.of(context).size.height/14.5,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("John Doe -- ${DateFormat('MMM d,yyyy,HH:mm:ss a').format(DateTime.now()).toString()}",
                           style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("This is a test note"),
                          
                        ],
                      )
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNote()));
        },
        child: Icon(Icons.add), 
      ),
    );
  }
}

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.blueGrey,),
          onPressed: (){
            Navigator.of(context).pop();
          }
         ),
        backgroundColor: Colors.white,
        title: Text("Add Note",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right:10,top:8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/2,
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
             child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Note",style: TextStyle(fontSize:size.height/45)),
                  // SizedBox( height: MediaQuery.of(context).size.height/80,),
                   Container(
                      alignment: Alignment.topLeft,
                      height: MediaQuery.of(context).size.height/3,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey,width: 1)
                      ) ,
                      child: TextField(
                        maxLines: 5,
                        // controller: explainTextController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          hintText: "Enter Note",
                           hintStyle: TextStyle(fontSize: size.height/50),
                          border: InputBorder.none
                        ),
                        onChanged: (val){
                           setState(() {
                            
                           });
                        },
                      ),
                    ),
                   
                    SizedBox( height: MediaQuery.of(context).size.height/30,),
                    Row(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height/25,
                          width:  MediaQuery.of(context).size.width/3.5,
                          decoration: BoxDecoration(
                             border: Border.all(color: Colors.black,width: 1),

                          ),
                          child: InkWell(
                            onTap: (){},
                            child: Container(
                              alignment: Alignment.center,
                              child: Text("CANCEL"),
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/20,),
                        Container(
                          height: MediaQuery.of(context).size.height/25,
                          width:  MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black,width: 1),
                          ),
                          child: InkWell(
                            onTap: (){},
                            child: Container(
                              color: Colors.blue,
                              alignment: Alignment.center,
                              child: Text("ADD NOTE",style: TextStyle(color:Colors.white),)
                            ),
                          ),
                        )
                      ],
                    )
                
                ],
              ),
            ),
          ),
        ),
      ),
      
    );
  }
}
