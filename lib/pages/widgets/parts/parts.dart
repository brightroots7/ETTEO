

import 'package:etteo_demo/bloc/parts_bloc.dart';
import 'package:etteo_demo/helpers/date_helper.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/helpers/string_helper.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_selectable_text/flutter_selectable_text.dart' as fst;

class Parts extends StatefulWidget {
  final PartsModel part;

  Parts({@required this.part});

  @override
  _PartsState createState() => _PartsState();
}

class _PartsState extends State<Parts> with AutomaticKeepAliveClientMixin {
  //this bloc is for displaying and adding parts data
  PartsBloc bloc;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<PartsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(5),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(screenAwareSize(10, 20, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                cardRow(context, "Make", checkNull(widget.part.make), "Model",
                    checkNull(widget.part.model)),
                cardRow(
                    context,
                    "Serial Number",
                    checkNull(widget.part.serialNumber),
                    "Unit Type",
                    checkNull(widget.part.unitType)),
                titleText('Description', context),
                descriptionText(
                    checkNull(widget.part.unitDescription), context),
                cardRow(context, "Status", checkNull(widget.part.unitStatus),
                    "Location", checkNull(widget.part.unitLocation)),
                titleText('ETA', context),
                descriptionText(
                    widget.part.estimatedTimeOfArrival != null
                        ? getDateAloneFromString(
                            widget.part.estimatedTimeOfArrival)
                        : "-",
                    context),
                /*titleText("Make", context),
                        descriptionText("Lorem Ipsum", context),
                        titleText("Model", context),
                        descriptionText("Lorem Ipsum", context),
                        titleText("Serial Number", context),
                        descriptionText("09128734", context),*/
                SizedBox(
                  height: screenAwareSize(15, 30, context),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Padding headerText(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenAwareSize(4, 8, context),
          bottom: screenAwareSize(4, 8, context),
          left: screenAwareSize(4, 8, context)),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: screenAwareSize(20, 40, context),
            fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  fst.SelectableText descriptionText(String text, BuildContext context) {
    return fst.SelectableText(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: screenAwareSize(15, 30, context),
        color: Colors.black54,
      ),
      //maxLines: 1,
      //overflow: TextOverflow.ellipsis,
    );
  }

  Padding titleText(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenAwareSize(10, 20, context),
          bottom: screenAwareSize(2, 4, context)),
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
            size: screenAwareSize(20, 40, context),
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
}
