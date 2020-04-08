
import 'package:etteo_demo/bloc/service_bloc.dart';
import 'package:etteo_demo/bloc/service_state.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/pages/widgets/services/create_services.dart';
import 'package:etteo_demo/pages/widgets/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceList extends StatefulWidget {
  final OrderDetailModel orderDetail;

  ServiceList({@required this.orderDetail});

  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList>
    with AutomaticKeepAliveClientMixin {
  ServiceBloc _serviceBloc;

  @override
  void initState() {
    super.initState();
    _serviceBloc = BlocProvider.of<ServiceBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _serviceBloc.orderDetailModel = widget.orderDetail;
    return BlocListener(
        bloc: _serviceBloc,
        listener: (BuildContext context, ServiceState state) {
          if (state is NewServiceAdded) {
            Scaffold.of(context).showSnackBar(
                progressSnackBarSuccess('Service creation success'));
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
                        headerText("Services", context),
                        Expanded(
                            child: BlocBuilder(
                          bloc: _serviceBloc,
                          builder: (BuildContext context, ServiceState state) {
                            if (state is NewServiceAdding) {
                              return showSpinner();
                            }

                            return serviceListView(
                                widget.orderDetail.order.services);
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
                              value: _serviceBloc,
                              child: CreateService(widget.orderDetail))),
                    );
                  },
                ))));
  }

  Widget serviceListView(List<ServicesModel> services) {
    return services != null && services.length > 0
        ? ListView.builder(
            padding: const EdgeInsets.all(0.0),
            itemCount: services.length,
            itemBuilder: (context, int) {
              return Container(
                  // margin:
                  //     EdgeInsets.only(top: screenAwareSize(10, 20, context)),
                  child: Service(
                service: services[int],
                orderDetailModel: widget.orderDetail,
              ));
              // child: Service(note: snapshot.data));
            },
          )
        : Center(
            child: Text("No service created yet"),
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
