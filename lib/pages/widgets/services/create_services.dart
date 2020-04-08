
import 'package:etteo_demo/bloc/service_bloc.dart';
import 'package:etteo_demo/bloc/service_event.dart';
import 'package:etteo_demo/bloc/service_state.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/model/services/service_component_model.dart';
import 'package:etteo_demo/model/services/service_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateService extends StatefulWidget {
  final OrderDetailModel orderDetail;

  CreateService(this.orderDetail);
  @override
  _CreateServiceState createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService>
    with AutomaticKeepAliveClientMixin {
  // please check all the comments on the code
  //this bloc is for displaying and adding service data
  ServiceBloc serviceBloc;
  ServicesModel newServiceModel = ServicesModel.fromJson(Map());
  var formKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    serviceBloc = BlocProvider.of<ServiceBloc>(context);
    serviceBloc
      ..dispatch(FetchServicesDropdownValues(
          lineOfBusinessGuid:
              widget.orderDetail.order.lineOfBusiness.lineOfBusinessGuid));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    serviceBloc = BlocProvider.of<ServiceBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            topAppbar(context),
            BlocBuilder(
                bloc: serviceBloc,
                builder: (context, state) {
                  if (state is ServiceDropdownValuesFetching) {
                    return showSpinnerInExpanded();
                  }
                  if (state is ServiceDropdownValuesFetched) {
                    return Container(
                      margin: EdgeInsets.all(screenAwareSize(10, 20, context)),
                      child: Card(
                        elevation: 5,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: screenAwareSize(10, 20, context),
                              ),
                              titleText('Component', context),
                              serviceComponentDropdown(
                                  dropdownList: serviceBloc.serviceComponents),
                              // selectDropdown(
                              //     serviceBloc.serviceComponents, 'Component'),
                              titleText('Service', context),
                              serviceTypeDropdown(
                                  dropdownList: serviceBloc.serviceTypes),
                              // selectDropdown(serviceBloc.serviceList, 'Service'),
                              titleText('Description', context),
                              descriptionField(),
                              buttons(context),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                }),
          ],
        ),
      ),
    );
  }

  Stack topAppbar(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        SizedBox(
          height: screenAwareSize(90, 180, context),
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          color: Color.fromARGB(200, 12, 49, 110),
          height: screenAwareSize(90, 180, context),
          width: MediaQuery.of(context).size.width,
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: screenAwareSize(25, 50, context),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            headerText("Add Service", context),
          ],
        )
      ],
    );
  }

  //SelectDropdown dropdown
  serviceTypeDropdown(
      {List<ServiceTypeModel> dropdownList, String type: 'Service'}) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenAwareSize(8, 16, context),
          right: screenAwareSize(8, 16, context),
          top: screenAwareSize(4, 8, context),
          bottom: screenAwareSize(8, 16, context)),
      child: FormField<String>(
        validator: (value) {
          if (value == null) {
            return "Select " + type;
          } else {
            return null;
          }
        },
//         onSaved: (value) {
//           //save data into model here
//           if (type == 'Component') {
//             print(value);
// //       model.componet = value;
//           } else if (type == 'Service') {
//             print(value);
// //       model.service = value;
//           }
//         },
        builder: (
          FormFieldState<String> state,
        ) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 9,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<ServiceTypeModel>(
                            hint: Text('Select ' + type),
                            isDense: true,
                            value: serviceBloc.selectedServiceTypeGuid,
                            items: dropdownList.map((ServiceTypeModel item) {
                              return DropdownMenuItem<ServiceTypeModel>(
                                child: Text(item.serviceTypeName),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              state.didChange(value.serviceTypeGuid);
                              // setState(() {
                              serviceBloc.selectedServiceTypeGuid = value;
                              newServiceModel.serviceTypeId =
                                  value.serviceTypeGuid;
                              newServiceModel.serviceType =
                                  value.serviceTypeName;
                              newServiceModel.serviceTime = value.noOfHours;

                              // });
                            }),
                      ),
                    )
                  ],
                ),
              ),
              state.hasError
                  ? SizedBox(height: 5.0)
                  : Container(
                      height: 0,
                    ),
              state.hasError
                  ? Text(
                      state.errorText,
                      style:
                          TextStyle(color: Colors.red.shade700, fontSize: 12.0),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

//SelectDropdown dropdown
  serviceComponentDropdown(
      {List<ServiceComponentModel> dropdownList, String type: 'Component'}) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenAwareSize(8, 16, context),
          right: screenAwareSize(8, 16, context),
          top: screenAwareSize(4, 8, context),
          bottom: screenAwareSize(8, 16, context)),
      child: FormField<String>(
        validator: (value) {
          if (value == null) {
            return "Select " + type;
          } else {
            return null;
          }
        },
//         onSaved: (value) {
//           //save data into model here
//           if (type == 'Component') {
//             print(value);
// //       model.componet = value;
//           } else if (type == 'Service') {
//             print(value);
// //       model.service = value;
//           }
//         },
        builder: (
          FormFieldState<String> state,
        ) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 9,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<ServiceComponentModel>(
                            hint: Text('Select ' + type),
                            isDense: true,
                            value: serviceBloc.selectedServiceComponentGuid,
                            items:
                                dropdownList.map((ServiceComponentModel item) {
                              return DropdownMenuItem<ServiceComponentModel>(
                                child: Text(item.serviceComponentName),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              state.didChange(value.serviceComponentGuid);
                              // setState(() {
                              serviceBloc.selectedServiceComponentGuid = value;
                              newServiceModel.serviceComponentId =
                                  value.serviceComponentGuid;
                              newServiceModel.serviceComponent =
                                  value.serviceComponentName;

                              // if (type == 'Component') {
                              //   setState(() {
                              //     serviceBloc.componentDropdownValue = value;
                              //   });
                              // } else if (type == 'Service') {
                              //   setState(() {
                              //     serviceBloc.serviceDropdownValue = value;
                              //   });
                              // }
                            }),
                      ),
                    )
                  ],
                ),
              ),
              state.hasError
                  ? SizedBox(height: 5.0)
                  : Container(
                      height: 0,
                    ),
              state.hasError
                  ? Text(
                      state.errorText,
                      style:
                          TextStyle(color: Colors.red.shade700, fontSize: 12.0),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Padding descriptionField() {
    return Padding(
      padding: EdgeInsets.only(
          left: screenAwareSize(8, 16, context),
          right: screenAwareSize(8, 16, context),
          top: screenAwareSize(4, 8, context)),
      child: TextFormField(
          maxLines: 10,
          minLines: 6,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(screenAwareSize(3, 6, context)),
                gapPadding: 0,
              ),
              hintText: 'Enter Description'),
          onSaved: (value) {
            //store your value here
//            model.description = value
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Description can\'t be empty';
            } else {
              newServiceModel.serviceDescription = value;
              return null;
            }
          }),
    );
  }

  Padding buttons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenAwareSize(8.0, 16, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: RaisedButton(
              color: Colors.white,
              elevation: 5,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1)),
              child: Text(
                'CANCEL',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: screenAwareSize(13, 26, context)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            width: screenAwareSize(10, 20, context),
          ),
          Expanded(
            flex: 2,
            child: RaisedButton(
              color: Colors.blue,
              elevation: 5,
              child: Text(
                'ADD SERVICE',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenAwareSize(13, 26, context)),
              ),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();

                  //save data into database by calling this function
                  newServiceModel.serviceStatus = "Open";
                  serviceBloc.dispatch(AddNewService(
                      orderId: widget.orderDetail.orderId,
                      service: newServiceModel));

                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding headerText(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: screenAwareSize(8, 16, context)),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: screenAwareSize(20, 40, context),
            fontWeight: FontWeight.bold,
            color: Colors.white),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Align titleText(String text, BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: screenAwareSize(8.0, 16.0, context)),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: screenAwareSize(15, 30, context),
              fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
