
import 'package:etteo_demo/bloc/documents_bloc.dart';
import 'package:etteo_demo/bloc/general_information_bloc.dart';
import 'package:etteo_demo/bloc/landing_bloc.dart';
import 'package:etteo_demo/bloc/landing_event.dart';
import 'package:etteo_demo/bloc/notes_bloc.dart';
import 'package:etteo_demo/bloc/order_details_bloc.dart';
import 'package:etteo_demo/bloc/parts_bloc.dart';
import 'package:etteo_demo/bloc/service_bloc.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/helpers/string_helper.dart';
import 'package:etteo_demo/model/route/route_model.dart';
import 'package:etteo_demo/model/route/route_status_model.dart';
import 'package:etteo_demo/pages/widgets/order/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routing extends StatefulWidget {
  final RouteModel routeModel;

  Routing({@required this.routeModel});

  @override
  _RoutingState createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  // OrdersBloc _ordersBloc;
  NotesBloc _notesBloc;
  PartsBloc _partsBloc;
  ServiceBloc _serviceBloc;
  DocumentsBloc _documentsBloc;
  LandingBloc _landingBloc;
  GeneralInformationBloc _generalInformationBloc;

  Icon routeStatus = Icon(Icons.more_vert);

  @override
  void initState() {
    super.initState();
    _landingBloc = BlocProvider.of<LandingBloc>(context);
    _notesBloc = NotesBloc();
    _partsBloc = PartsBloc();
    _serviceBloc = ServiceBloc();
    _documentsBloc = DocumentsBloc();
    _generalInformationBloc = GeneralInformationBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _notesBloc?.dispose();
    _partsBloc?.dispose();
    _serviceBloc?.dispose();
    _documentsBloc?.dispose();
    _generalInformationBloc?.dispose();
    print('!!! dispose notes, parts, service and document bloc');
  }

  @override
  Widget build(BuildContext context) {
    if (_landingBloc.routeStatus.isEmpty && AppConfig().isOnline) {
      _landingBloc.dispatch(FetchRouteStatus());
    }
    setRouteStatusIcon(widget.routeModel.order.service.routeStatusId);
    return InkWell(
        child: Card(
            elevation: 5.0,
            color: Color.fromARGB(245, 250, 250, 250),
            child: Column(children: <Widget>[
              ListTile(
                trailing: Text(widget.routeModel.order.service.serviceStatus,
                    style: TextStyle(
                        fontFamily: 'Roboto', fontWeight: FontWeight.w500)),
                title: Text(
                  widget.routeModel.order.etteoOrderId,
                  style: TextStyle(
                      fontFamily: 'Roboto', fontWeight: FontWeight.w500),
                ),

                // leading: Icon(Icons.flag),
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textBold(context, widget.routeModel.order.orderSource),
                    // Text(order.orderSource,
                    //     style: TextStyle(fontWeight: FontWeight.w600)),
                    textNormal(context, widget.routeModel.order.sourceId)
                  ],
                ),
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textBold(context,
                        widget.routeModel.order.service.serviceComponent),
                    textNormal(
                        context, widget.routeModel.order.service.serviceType),
                    textSmall(context,
                        checkNull(widget.routeModel.order.service.description)),
                    Text(
                        widget.routeModel.order.service.timeStart +
                            ' - ' +
                            widget.routeModel.order.service.timeEnd,
                        style: Theme.of(context).textTheme.title),
                  ],
                ),
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textBold(context, widget.routeModel.order.customerName),
                    textNormal(
                        context, widget.routeModel.order.customerPhoneNo),
                    textNormal(
                        context, widget.routeModel.order.customerAddress),
                    textNormal(
                        context, widget.routeModel.order.customerCityStateZip),
                    // Text(order.customerEmailAddress),
                    // textNormal(context, widget.routeModel.order.customerPhoneNo)
                  ],
                ),
              ),
              ListTile(
                  title: widget.routeModel.order.flags != null &&
                          widget.routeModel.order.flags.length > 0
                      ? Row(children: getFlagIcons())
                      : Container(),
                  trailing: PopupMenuButton(
                    // icon: Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) {
                      return _landingBloc.routeStatus
                          .map((RouteStatusModel rs) {
                        return PopupMenuItem<RouteStatusModel>(
                          value: rs,
                          child: Text(rs.routeStatusDescription),
                        );
                      }).toList();
                    },
                    icon: routeStatus,
                    onSelected: (RouteStatusModel value) {
                      widget.routeModel.order.service.routeStatusId =
                          value.routeStatusId;
                      widget.routeModel.order.service.routeStatus =
                          value.routeStatusDescription;

                      // Update Route for offline
                      value.routeStatusUpdatedTime =
                          DateTime.now().toUtc().toString();
                      // Update Route status
                      _landingBloc.dispatch(UpdateRouteStatus(
                          routeId: widget.routeModel.routeId,
                          routeStatusModel: value));
                      // widget

                      _landingBloc
                          .dispatch(UpdateRoute(routeModel: widget.routeModel));

                      setRouteStatusIcon(
                          widget.routeModel.order.service.routeStatusId);
                      // _ordersBloc.changeIcon(value, index);
                    },
                  )),
            ])),
        onTap: () {
          // NotesBloc _notesBloc = BlocProvider.of<NotesBloc>(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Scaffold(
                      body: MultiBlocProvider(
                    providers: [
                      BlocProvider<NotesBloc>.value(
                        value: _notesBloc,
                      ),
                      BlocProvider<ServiceBloc>.value(value: _serviceBloc),
                      BlocProvider<PartsBloc>.value(value: _partsBloc),
                      BlocProvider<DocumentsBloc>.value(value: _documentsBloc),
                      BlocProvider<GeneralInformationBloc>.value(
                          value: _generalInformationBloc),
                      BlocProvider<OrderDetailsBloc>(
                        builder: (context) => OrderDetailsBloc(),
                      ),
                    ],
                    child: Scaffold(
                        body: OrderDetails(
                            orderId: widget.routeModel.order.orderId)),
                  ))));
        });
  }

  List<Icon> getFlagIcons() {
    List<Icon> flagIcons = List();

    int red = 0, green = 0, blue = 0, orange = 0, yellow = 0;
    String col;
    widget.routeModel.order.flags.forEach((i) => {
          col = i.color.toLowerCase(),
          if (col == "red")
            {red++}
          else if (col == "green")
            {green++}
          else if (col == "yellow")
            {yellow++}
          else if (col == "orange")
            {orange++}
          else if (col == "blue")
            {blue++},
          if ((red == 1 && col == "red") ||
              (blue == 1 && col == "blue") ||
              (green == 1 && col == "green") ||
              (yellow == 1 && col == "yellow") ||
              (orange == 1 && col == "orange"))
            {
              flagIcons.add(Icon(
                Icons.flag,
                size: screenAwareSize(20, 40, context),
                color: getIconColor(col),
              ))
            }
        });
    return flagIcons;
  }

  setRouteStatusIcon(String routeStatusId) {
    if (widget.routeModel.order.service.routeStatusId == null) {
      return Icon(Icons.more_vert);
    }

    List<RouteStatusModel> rs = _landingBloc.routeStatus
        .where((rsm) => rsm.routeStatusId == routeStatusId)
        .toList();
    String iconName;
    if (rs.isNotEmpty) {
      iconName = rs.first.routeIcon;
    }

    IconData iconData;
    switch (iconName) {
      case 'local_shipping':
        iconData = Icons.local_shipping;
        break;

      case 'build':
        iconData = Icons.build;
        break;

      case 'report_problem':
        iconData = Icons.report_problem;
        break;

      case 'assignment_turned_in':
        iconData = Icons.assignment_turned_in;
        break;
    }

    setState(() {
      routeStatus = Icon(iconData);
    });

    // return Icon(iconData);
  }

  MaterialColor getIconColor(String color) {
    MaterialColor iconColor;
    switch (color) {
      case "red":
        iconColor = Colors.red;
        break;
      case "green":
        iconColor = Colors.green;
        break;
      case "blue":
        iconColor = Colors.blue;
        break;
      case "orange":
        iconColor = Colors.orange;
        break;
      case "yellow":
        iconColor = Colors.yellow;
        break;
    }

    return iconColor;
  }

//bold Text in Card
  Text textBold(
    BuildContext context,
    String text,
  ) {
    return Text(
      text,
      style: TextStyle(
          fontSize: screenAwareSize(13, 30, context),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold),
    );
  }

//normal Text in Card
  Text textNormal(
    BuildContext context,
    String text,
  ) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Roboto', fontSize: screenAwareSize(12, 26, context)),
    );
  }

//small Text in Card
  Text textSmall(
    BuildContext context,
    String text,
  ) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Roboto', fontSize: screenAwareSize(10, 26, context)),
    );
  }
}
