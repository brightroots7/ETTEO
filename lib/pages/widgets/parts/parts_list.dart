

import 'package:etteo_demo/bloc/parts_bloc.dart';
import 'package:etteo_demo/bloc/parts_state.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:etteo_demo/pages/widgets/parts/create_parts.dart';
import 'package:etteo_demo/pages/widgets/parts/parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartsList extends StatefulWidget {
  final OrderDetailModel orderDetail;

  PartsList({@required this.orderDetail});

  @override
  _PartsListState createState() => _PartsListState();
}

class _PartsListState extends State<PartsList>
    with AutomaticKeepAliveClientMixin {
  PartsBloc _partsBloc;

  @override
  void initState() {
    super.initState();
    _partsBloc = BlocProvider.of<PartsBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _partsBloc.orderDetailModel = widget.orderDetail;
    return BlocListener(
        bloc: _partsBloc,
        listener: (BuildContext context, PartsState state) {
          if (state is NewPartsAdded) {
            Scaffold.of(context)
                .showSnackBar(progressSnackBarSuccess('Part creation success'));
          }
        },
        child: Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: EdgeInsets.all(screenAwareSize(10, 20, context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        headerText("Parts", context),
                        Expanded(
                            child: BlocBuilder(
                          bloc: _partsBloc,
                          builder: (BuildContext context, PartsState state) {
                            if (state is NewPartsAdding) {
                              return showSpinner();
                            }

                            return partsListView(
                                widget.orderDetail.order.units);
                          },
                        )),
                      ],
                    ))),
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                              value: _partsBloc,
                              child: CreateParts(
                                  orderId: widget.orderDetail.orderId))),
                    );
                  },
                ))));
  }

  Widget partsListView(List<PartsModel> parts) {
    return parts != null && parts.length > 0
        ? ListView.builder(
            padding: const EdgeInsets.all(0.0),
            itemCount: parts.length,
            itemBuilder: (context, int) {
              return Container(
                  // margin:
                  //     EdgeInsets.only(top: screenAwareSize(10, 20, context)),
                  child: Parts(part: parts[int]));
              // child: Service(note: snapshot.data));
            },
          )
        : Center(
            child: Text("No parts created yet"),
          );
  }

  @override
  bool get wantKeepAlive => true;
}

Padding headerText(String text, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
        left: screenAwareSize(3.0, 6.0, context),
        bottom: screenAwareSize(3, 6, context)),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: screenAwareSize(20, 40, context),
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
