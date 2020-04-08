
import 'package:etteo_demo/bloc/service_bloc.dart';
import 'package:etteo_demo/bloc/wizard_bloc.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/helpers/string_helper.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/pages/widgets/services/start_wizard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_selectable_text/flutter_selectable_text.dart' as fst;

class Service extends StatefulWidget {
  final OrderDetailModel orderDetailModel;
  ServicesModel service;
  Service({@required this.service, this.orderDetailModel});
  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> with AutomaticKeepAliveClientMixin {
  // please check all the comments on the code
  //this serviceBloc is for displaying and adding service data
  ServiceBloc serviceBloc;
  WizardBloc wizardBloc;
  // var formKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    serviceBloc = BlocProvider.of<ServiceBloc>(context);
    wizardBloc = WizardBloc();
    super.initState();
  }

  @override
  void dispose() {
    print('wizardbloc dispose from services');
    wizardBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (wizardBloc.closed) widget.service = wizardBloc.cloneServiceModel;
    super.build(context);
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleText('Component', context),
                descriptionText(widget.service.serviceComponent, context),
                titleText('Service', context),
                descriptionText(widget.service.serviceType, context),
                titleText('Description', context),
                descriptionText(widget.service.serviceDescription, context),
                titleText('Service Provider', context),
                descriptionText(widget.service.serviceProvider, context),
                titleText('Assigned Resource', context),
                descriptionText(widget.service.resource, context),
                cardRow(
                    context,
                    "Duration",
                    widget.service.serviceTime.toString() + ' Hours',
                    "Status",
                    widget.service.serviceStatus),
                cardRow(
                    context,
                    "Date",
                    widget.service.serviceDate != null
                        ? DateFormat.yMMMd()
                            .format(DateTime.parse(widget.service.serviceDate))
                        : "-",
                    "Time",
                    getTimeWindow()),
                buttons(context)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ));
  }

  String getTimeWindow() {
    if (widget.service.timeStart == null) {
      return "-";
    }

    return widget.service.timeStart + ' - ' + widget.service.timeEnd;
  }

  Padding cardRow(BuildContext context, String titleOne, String descritionOne,
      String titleTwo, String descriptionTwo) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenAwareSize(4, 8, context),
          bottom: screenAwareSize(4, 8, context)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleText(titleOne, context),
                descriptionText(descritionOne, context)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleText(titleTwo, context),
                descriptionText(descriptionTwo, context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Expanded(
          flex: 2,
          child: enableResolveButton()
              ? RaisedButton(
                  color: Color.fromARGB(200, 12, 49, 110),
                  elevation: 5,
                  child: Text(
                    'RESOLVE',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenAwareSize(13, 26, context)),
                  ),
                  onPressed: () {
                    /// Starting the wizard
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Scaffold(
                          body: BlocProvider<WizardBloc>.value(
                              value: wizardBloc,
                              child: ServiceResolveWizard(
                                  orderDetail: widget.orderDetailModel,
                                  serviceModel: widget.service)),
                        ),
                      ),
                    );
                  }
                  // },
                  )
              : assignedResource()
                  ? Text(
                      widget.service.serviceStatus,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.blue,
                          fontWeight: FontWeight.w900),
                    )
                  : Text(""),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  bool enableResolveButton() {
    if (widget.service.serviceStatus == "Open" && assignedResource()) {
      return true;
    }
    return false;
  }

  bool assignedResource() {
    return (widget.service.resourceId != null &&
        widget.service.resourceId == AppConfig().userProfile.resourceId);
  }

  Padding headerText(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenAwareSize(6, 12, context)),
      child: fst.SelectableText(
        checkNull(text),
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: screenAwareSize(20, 40, context),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  fst.SelectableText descriptionText(String text, BuildContext context) {
    return fst.SelectableText(
      checkNull(text),
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: screenAwareSize(15, 30, context),
        color: Colors.black54,
      ),
    );
  }

  Padding titleText(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenAwareSize(6, 12, context),
          bottom: screenAwareSize(3, 6, context)),
      child: Text(
        checkNull(text),
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: screenAwareSize(15, 30, context),
            fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Padding subTitleText(String text, icon, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenAwareSize(4, 8, context),
          bottom: screenAwareSize(4, 8, context)),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: screenAwareSize(20, 40, context),
            color: Colors.black54,
          ),
          SizedBox(
            width: screenAwareSize(10, 20, context),
          ),
          Text(
            checkNull(text),
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: screenAwareSize(15, 30, context),
              color: Colors.black54,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
