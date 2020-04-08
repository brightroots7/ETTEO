

import 'package:etteo_demo/bloc/wizard_bloc.dart';
import 'package:etteo_demo/bloc/wizard_event.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/model/services/service_component_model.dart';
import 'package:etteo_demo/model/services/service_type_model.dart';
import 'package:etteo_demo/pages/widgets/wizard/are_parts_required.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';



class ToBeCompleted extends StatefulWidget {
  @override
  _ToBeCompletedState createState() => _ToBeCompletedState();
}

class _ToBeCompletedState extends State<ToBeCompleted> {
  WizardBloc _wizardBloc;
  var formKey = new GlobalKey<FormState>();
  var description;

  ServicesModel newServiceModel = ServicesModel.fromJson({});

  @override
  Widget build(BuildContext context) {
    _wizardBloc = BlocProvider.of<WizardBloc>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Theme.of(context).primaryColor,
      appBar: new AppBar(
        title: new Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              onPressed: () => {
                    _wizardBloc.dispatch(CloseWizard()),
                    Navigator.of(context).pop(),
                  }),
        ],
        leading: new Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: screenAwareSize(20, 40, context),
            ),
            Container(
              padding: EdgeInsets.only(left: screenAwareSize(10, 8, context)),
              child: Align(
                //alignment: Alignment(-0.7, 0.6),
                child: Text(
                  "What work needs to be completed?", //Concatenate the appropriate SERVICE name
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: screenAwareSize(20, 40, context)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenAwareSize(30, 60, context)),
              child: Hero(
                  tag: 'logo',
                  child: Image.asset('assets/images/services.png',
                      width: screenAwareSize(350, 700, context))),
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  selectServiceComponentDropdown(
                      _wizardBloc.serviceComponents, 'Components'),
                  selectServiceTypeDropdown(
                      _wizardBloc.serviceTypes, 'Service'),
                  new Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenAwareSize(20, 40, context)),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                          maxLines: 10,
                          minLines: 4,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    screenAwareSize(5, 6, context)),
                                gapPadding: 0,
                              ),
                              hintText: 'Description of work completed'),
                          onSaved: (value) {
                            //store your value here
                            newServiceModel.serviceDescription = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Description can\'t be empty';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: screenAwareSize(15, 30, context)),
                    child: ButtonTheme(
                      minWidth: 200.0,
                      child: OutlineButton(
                        child: new Text(
                          "NEXT",
                          style: new TextStyle(
                            fontFamily: 'Roboto',
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                            fontSize: screenAwareSize(20, 40, context),
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        color: Colors.green[300],
                        borderSide: BorderSide(
                          color: Color(0xffa6b2c1), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1.0, //width of the border
                        ),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();

                            newServiceModel.serviceStatus = "Open";
                            newServiceModel.serviceComponent = _wizardBloc
                                .selectedServiceComponentGuid
                                .serviceComponentName;
                            newServiceModel.serviceComponentId = _wizardBloc
                                .selectedServiceComponentGuid
                                .serviceComponentGuid;

                            newServiceModel.serviceType = _wizardBloc
                                .selectedServiceTypeGuid.serviceTypeName;
                            newServiceModel.serviceTypeId = _wizardBloc
                                .selectedServiceTypeGuid.serviceTypeGuid;

                            _wizardBloc.dispatch(
                                AddWizardService(service: newServiceModel));

                            /// Redirect to PartsRequired
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: _wizardBloc,
                                  child: PartsRequired(),
                                ),
                              ),
                            );
                          }
                        },
                      ),
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

  //SelectDropdown dropdown
  selectServiceTypeDropdown(List<ServiceTypeModel> dropdownList, type) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenAwareSize(20, 40, context),
          right: screenAwareSize(20, 40, context),
          top: screenAwareSize(15, 30, context),
          bottom: screenAwareSize(15, 30, context)),
      child: FormField<String>(
        validator: (value) {
          if (value == null) {
            return "Select " + type;
          } else {
            return null;
          }
        },
        onSaved: (value) {
          //save data into model here
//       model.service = value;
        },
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
                            value: _wizardBloc.selectedServiceTypeGuid,
                            items: dropdownList.map((ServiceTypeModel item) {
                              return DropdownMenuItem<ServiceTypeModel>(
                                child: Text(item.serviceTypeName),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              state.didChange(value.serviceTypeGuid);

                              newServiceModel.serviceType =
                                  value.serviceTypeName;
                              newServiceModel.serviceTypeId =
                                  value.serviceTypeGuid;

                              _wizardBloc.selectedServiceTypeGuid = value;
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
                      style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: screenAwareSize(12, 24, context)),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  selectServiceComponentDropdown(
      List<ServiceComponentModel> dropdownList, type) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenAwareSize(20, 40, context),
          right: screenAwareSize(20, 40, context),
          top: screenAwareSize(15, 30, context),
          bottom: screenAwareSize(15, 30, context)),
      child: FormField<String>(
        validator: (value) {
          if (value == null) {
            return "Select " + type;
          } else {
            return null;
          }
        },
        onSaved: (value) {
          //save data into model here
//       model.service = value;
        },
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
                            value: _wizardBloc.selectedServiceComponentGuid,
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
                              newServiceModel.serviceComponent =
                                  value.serviceComponentName;
                              newServiceModel.serviceComponentId =
                                  value.serviceComponentGuid;
                              _wizardBloc.selectedServiceComponentGuid = value;
                              // _wizardBlocserviceDropdownValue = value;
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
                      style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: screenAwareSize(12, 24, context)),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
