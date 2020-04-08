
import 'package:etteo_demo/bloc/wizard_bloc.dart';
import 'package:etteo_demo/bloc/wizard_event.dart';
import 'package:etteo_demo/bloc/wizard_state.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/pages/widgets/wizard/is_the_service_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceResolveWizard extends StatefulWidget {
  ServicesModel serviceModel;
  final OrderDetailModel orderDetail;
  ServiceResolveWizard({this.orderDetail, this.serviceModel});

  @override
  _ServiceResolveWizardState createState() => _ServiceResolveWizardState();
}

class _ServiceResolveWizardState extends State<ServiceResolveWizard> {
  WizardBloc _wizardBloc;

  @override
  void initState() {
    _wizardBloc = _wizardBloc = BlocProvider.of<WizardBloc>(context);
    _wizardBloc.selectedService = widget.serviceModel;
    _wizardBloc.selectedOrderDetail = widget.orderDetail;
    _wizardBloc.dispatch(InitialWizardEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder(
        bloc: _wizardBloc..dispatch(FetchWizardDropdownValues()),
        builder: (BuildContext context, WizardState state) {
          if (state is WizardDropdownValuesFetched) {
            return BlocProvider<WizardBloc>.value(
              value: _wizardBloc,
              child: Complete(),
            );
          }
          return showSpinner();
        },
      ),
    );
  }
}
