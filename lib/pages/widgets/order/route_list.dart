
import 'package:etteo_demo/bloc/landing_bloc.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/models.dart';
import 'package:etteo_demo/pages/widgets/order/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RoutingList extends StatelessWidget {
  final List<RouteModel> routes;

  RoutingList({@required this.routes});

  @override
  Widget build(BuildContext context) {
    // return _buildList(context);
    return ListView.builder(
      itemCount: routes.length,
      itemBuilder: (context, int) {
        return Container(
          margin: EdgeInsets.only(top: screenAwareSize(10, 20, context)),
          child: BlocProvider.value(
              value: BlocProvider.of<LandingBloc>(context),
              child: Routing(routeModel: routes[int])),
        );
      },
    );
  }
}
