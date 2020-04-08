

import 'package:etteo_demo/bloc/general_information_bloc.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/order_detail/flags_model.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/pages/widgets/generalInformation/flags.dart';
import 'package:etteo_demo/pages/widgets/generalInformation/service_fee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_selectable_text/flutter_selectable_text.dart' as fst;

class GeneralInformation extends StatefulWidget {
  final OrderDetailModel orderDetailModel;
   final List<FlagsModel> getAllFlagsDetailsModel;
  GeneralInformation({@required this.getAllFlagsDetailsModel, this.orderDetailModel});

  @override
  _GeneralInformationState createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  GeneralInformationBloc _generalInformationBloc;

  @override
  void initState() {
    _generalInformationBloc = BlocProvider.of<GeneralInformationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _generalInformationBloc.orderDetailModel = widget.orderDetailModel;
    super.build(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                orderHeaderText(
                    "Order: " + widget.orderDetailModel.order.etteoOrderId,
                    context),
                headerText("Flags", context),
                //flagsListView(widget.orderDetailModel.order.flags),
                Card(
                  margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // flagsListView(widget.orderDetailModel.order.flags),
                         flagsListView(widget.getAllFlagsDetailsModel),
                      ],
                    ),
                  ),
                ),
                headerText("General Information", context),
                Card(
                  margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            titleText('Line of Business', context),
                            Expanded(
                              child: Container(),
                            ),
                            SizedBox(
                              width: screenAwareSize(10, 20, context),
                            ),
                            // titleText('Open', context),
                            titleText(
                                widget.orderDetailModel.orderStatus, context)
                          ],
                        ),
                        subTitleText(
                            widget.orderDetailModel.order.lineOfBusiness
                                .lineOfBusinessDescription,
                            FontAwesomeIcons.wrench,
                            context),
                        titleText('Source', context),
                        subTitleText(
                            widget.orderDetailModel.order.orderSource
                                .orderSourceName,
                            FontAwesomeIcons.user,
                            context),
                        subTitleText(
                            widget.orderDetailModel.order.orderSource
                                .externalOrderId,
                            FontAwesomeIcons.clipboardList,
                            context),
                        titleText('Owner', context),
                        subTitleText(
                            widget.orderDetailModel.order.owner.ownerName,
                            FontAwesomeIcons.user,
                            context),
                        // titleText('Description', context),
                        // descriptionText(
                        //     "Example of a service description. Lorem Ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                        //     context),
                        SizedBox(
                          height: screenAwareSize(15, 30, context),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                headerText("Service Fee", context),
                ServiceFee(
                    orderId: widget.orderDetailModel.orderId,
                    finance: widget.orderDetailModel.order.finance)
              ],
            ),
          ),
        ),
      ),
    );
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

  Padding orderHeaderText(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenAwareSize(5, 10, context),
      ),
      child: fst.SelectableText(
        text,
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: screenAwareSize(18, 36, context),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding headerText(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenAwareSize(12, 24, context),
        left: screenAwareSize(5, 10, context),
      ),
      child: SelectableText(
        text,
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: screenAwareSize(18, 36, context),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  SelectableText descriptionText(String text, BuildContext context) {
    return SelectableText(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: screenAwareSize(14, 28, context),
        color: Colors.black54,
      ),
    );
  }

  Padding titleText(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: screenAwareSize(6, 12, context)),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: screenAwareSize(14, 28, context),
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
            size: screenAwareSize(14, 28, context),
            color: Colors.black54,
          ),
          SizedBox(
            width: screenAwareSize(10, 20, context),
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: screenAwareSize(14, 28, context),
              color: Colors.black54,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget flagsListView(List<FlagsModel> flags) {
    // Filter flags to show only open
    List<FlagsModel> filteredFlags =
        flags.where((f) => f.flagStatus == 'Open').toList();


        print("filteredFlags filteredFlagsfilteredFlags filteredFlags:$filteredFlags");

    return filteredFlags != null && filteredFlags.length > 0
        ? ListView.builder(
            padding: const EdgeInsets.all(0.0),
            itemCount: filteredFlags.length,
            shrinkWrap: true,
            itemBuilder: (context, int) {
              return Flags(flag: filteredFlags[int]);
              // child: Service(note: snapshot.data));
            },
            physics: const NeverScrollableScrollPhysics(),
          )
        : Center(
            child: Text(
              "No Flag Present",
              style: TextStyle(fontFamily: 'Roboto'),
            ),
          );
  }
}
