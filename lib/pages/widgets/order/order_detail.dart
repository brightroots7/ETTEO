

import 'package:etteo_demo/bloc/documents_bloc.dart';
import 'package:etteo_demo/bloc/general_information_bloc.dart';
import 'package:etteo_demo/bloc/notes_bloc.dart';
import 'package:etteo_demo/bloc/order_details_bloc.dart';
import 'package:etteo_demo/bloc/order_details_event.dart';
import 'package:etteo_demo/bloc/order_details_state.dart';
import 'package:etteo_demo/bloc/parts_bloc.dart';
import 'package:etteo_demo/bloc/service_bloc.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/model/order_detail/flags_model.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/pages/widgets/documents/documents_list.dart';
import 'package:etteo_demo/pages/widgets/generalInformation/general_information.dart';
import 'package:etteo_demo/pages/widgets/notes/notes_list.dart';
import 'package:etteo_demo/pages/widgets/parts/parts_list.dart';
import 'package:etteo_demo/pages/widgets/services/service_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:io' show Platform;






class OrderDetails extends StatefulWidget {
  final String orderId;

  OrderDetails({@required this.orderId});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>
    with TickerProviderStateMixin {
  TabController _tabController;
  OrderDetailsBloc orderDetailBloc;
  OrderDetailModel orderDetailModel;
  List<FlagsModel> getAllFlagsDetailsModel;

  var currentTab;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 5);
    _tabController.addListener(_handleTabSelection);
    orderDetailBloc = BlocProvider.of<OrderDetailsBloc>(context)
      ..dispatch(FetchLocalOrderDetail(orderId: widget.orderId));
  }

  //to enable or disable floating action button
  _handleTabSelection() {
    if (_tabController.index == 0) {
      //generalinfromation tab
      orderDetailBloc..dispatch(SetRouteFlag(flag: true));
    } else {
      //service,parts,documents,note tab
      orderDetailBloc..dispatch(SetRouteFlag(flag: false));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    orderDetailBloc = BlocProvider.of<OrderDetailsBloc>(context);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
    orderDetailBloc?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: orderDetailBloc,
      listener: (BuildContext context, OrderDetailsState state) {
        if (state is OrderDetailFetching) {
          progressSnackBarInfo('Fetching order detail.');
        }

        if (state is OrderDetailFetched) {
          Scaffold.of(context).hideCurrentSnackBar();
        }
      },
      child: Scaffold(
        // floatingActionButton: floatingActionButton(),
        bottomNavigationBar: bottomNavigationBar(),
        body: BlocBuilder(
            bloc: orderDetailBloc,
            builder: (BuildContext context, OrderDetailsState state) {
              if (state is OrderDetailFetched) {
                orderDetailModel = state.orderDetails;
                getAllFlagsDetailsModel = state.getAllFlagsDetails;
                return orderDetail(context, orderDetailModel, getAllFlagsDetailsModel);
              }

              if (state is OrderDetailFetching ||
                  state is LocalOrderDetailFetching) {
                return Center(child: CircularProgressIndicator());
              }
              // return Container();
              return orderDetailModel == null
                  ? Container()
                  : orderDetail(context, orderDetailModel,getAllFlagsDetailsModel);
              // : orderDetail(context, orderDetailModel)
            }),
      ),
    );
  }

  Widget orderDetail(BuildContext context, OrderDetailModel orderDetails, List<FlagsModel> flagsDetails ) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            topPart(context, orderDetails),
            Container(
              height: screenAwareSize(411, 399, context),
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  BlocProvider<GeneralInformationBloc>.value(
                    value: BlocProvider.of<GeneralInformationBloc>(context),
                    
                    child: GeneralInformation(getAllFlagsDetailsModel: getAllFlagsDetailsModel ,orderDetailModel: orderDetails),
                    // GeneralInformation(orderDetailModel: orderDetails),
                  ),
                  BlocProvider<ServiceBloc>.value(
                    value: BlocProvider.of<ServiceBloc>(context),
                    // builder: (context) => BlocProvider.of<ServiceBloc>(context),
                    child: ServiceList(orderDetail: orderDetails),
                  ),
                  BlocProvider<PartsBloc>.value(
                    value: BlocProvider.of<PartsBloc>(context),
                    // builder: (context) => BlocProvider.of<PartsBloc>(context),
                    child: PartsList(
                      orderDetail: orderDetails,
                    ),
                  ),
                  BlocProvider<DocumentsBloc>.value(
                    value:
                        // builder: (context) =>
                        BlocProvider.of<DocumentsBloc>(context),
                    child: DocumentsList(
                      orderDetail: orderDetails,
                    ),
                  ),
                  BlocProvider<NotesBloc>.value(
                    value: BlocProvider.of<NotesBloc>(context),
                    // builder: (context) => BlocProvider.of<NotesBloc>(context),
                    child: NotesList(
                      orderDetail: orderDetails,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  StatelessWidget bottomNavigationBar() {
    return Card(
      margin: EdgeInsets.all(1.0),
      elevation: 30,
      child: new PreferredSize(
        preferredSize: new Size(1.0, 2.0),
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          onTap: (int index) {
            setState(() {
              currentTab = index;
            });
          },
          tabs: [
            new Container(
                height: 60.0,
                child: Tab(
                    child: Icon(
                  FontAwesomeIcons.infoCircle,
                  color: currentTab == 0 ? Colors.blue : Colors.blueGrey,
                ))), //General Information
            new Container(
                height: 60.0,
                child: Tab(
                    child: Icon(
                  FontAwesomeIcons.tools,
                  color: currentTab == 1 ? Colors.blue : Colors.blueGrey,
                ))), //Services
            new Container(
                height: 60.0,
                child: Tab(
                    child: Icon(
                  FontAwesomeIcons.toolbox,
                  color: currentTab == 2 ? Colors.blue : Colors.blueGrey,
                ))), //Parts
            new Container(
                height: 60.0,
                child: Tab(
                    child: Icon(
                  FontAwesomeIcons.solidFileImage,
                  color: currentTab == 3 ? Colors.blue : Colors.blueGrey,
                ))), //Documents
            new Container(
                height: 60.0,
                child: Tab(
                    child: Icon(
                  FontAwesomeIcons.solidStickyNote,
                  color: currentTab == 4 ? Colors.blue : Colors.blueGrey,
                ))), //Notes
          ],
        ),
      ),
    );
  }

  Stack topPart(BuildContext context, OrderDetailModel orderDetailModel) {
    return Stack(
      children: <Widget>[
        SizedBox(
            height: screenAwareSize(200, 400, context),
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.blue,
            )),
        Container(
          color: Color.fromARGB(200, 12, 49, 110),
          height: screenAwareSize(200, 400, context),
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          top: screenAwareSize(18, 36, context),
          child: Padding(
            padding: EdgeInsets.only(
                top: screenAwareSize(20.0, 40, context),
                left: screenAwareSize(20.0, 40, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      Icons.arrow_back,
                      size: screenAwareSize(23, 46, context),
                      color: Colors.white,
                    ),
                    onPressed: () {
                      orderDetailBloc
                          .dispatch(UpdateOrderDetail(orderDetailModel));
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Text(
                  orderDetailModel.contactBusinessName(),
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: screenAwareSize(20, 40, context),
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenAwareSize(15, 30, context)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.local_phone,
                      color: Colors.white,
                    ),
                    SizedBox(width: screenAwareSize(15, 30, context)),
                    InkWell(
                      child: Text(
                        orderDetailModel.phoneNumber(),
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontSize: screenAwareSize(15, 30, context),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () =>
                          launchPhoneCall(orderDetailModel.phoneNumber()),
                    ),
                  ],
                ),
                SizedBox(height: screenAwareSize(14, 28, context)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    SizedBox(width: screenAwareSize(15, 30, context)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          child: Text(
                            orderDetailModel.address().addressLine1,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: screenAwareSize(15, 30, context),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () => launchMap(
                              orderDetailModel.address().addressLine1 +
                                  ', ' +
                                  orderDetailModel.address().city +
                                  ' ' +
                                  orderDetailModel.address().state),
                        ),
                        SizedBox(height: screenAwareSize(3, 6, context)),
                        InkWell(
                          child: Text(
                            orderDetailModel.address().cityStatePostalCode(),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: screenAwareSize(12, 24, context),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () => launchMap(
                              orderDetailModel.address().addressLine1 +
                                  ', ' +
                                  orderDetailModel.address().city +
                                  ' ' +
                                  orderDetailModel.address().state),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<bool> launchPhoneCall(String phoneNumber) async {
    String url = "tel://$phoneNumber";

    if (await canLaunch(url)) {
      return launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Future<bool> launchMap(String addressLine1) async {
  //  String urlGoogleMaps =
  //      "https://www.google.com/maps/search/?api=1&query=$addressLine1";
  //  String urlAppleMaps = "https://maps.apple.com/?query=$addressLine1";
  //  if (await canLaunch(urlGoogleMaps)) {
  //    print('launching google url');
  //    await launch(urlGoogleMaps);
  //    return true;
  //  } else if (await canLaunch(urlAppleMaps)) {
  //    print('launching apple url');
  //    await launch(urlAppleMaps);
  //    return true;
  //  } else {
  //    throw 'Could not launch maps';
  //  }
  //}

  launchMap(String addressLine1) async {
    // From a query
    final query = '$addressLine1';
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    Address first = addresses.first;
    //print("${first.featureName} : ${first.coordinates}");

    // Android
    var url = 'https://www.google.com/maps/search/?api=1&query=$addressLine1';
    if (Platform.isIOS) {
      // iOS
      url =
          'http://maps.apple.com/?q=${first.coordinates.latitude},${first.coordinates.longitude}';
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
