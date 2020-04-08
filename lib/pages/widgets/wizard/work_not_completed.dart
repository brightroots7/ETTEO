

import 'package:etteo_demo/bloc/wizard_bloc.dart';
import 'package:etteo_demo/bloc/wizard_event.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/services/service_sub_status_model.dart';
import 'package:etteo_demo/pages/widgets/wizard/additional_information_needed.dart';
import 'package:etteo_demo/pages/widgets/wizard/major_minor.dart';
import 'package:etteo_demo/pages/widgets/wizard/work_to_be_completed.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';


class WorkNotCompleted extends StatefulWidget {
  @override
  _WorkNotCompletedState createState() => _WorkNotCompletedState();
}

class _WorkNotCompletedState extends State<WorkNotCompleted> {
  WizardBloc _wizardBloc;
  var formKey = new GlobalKey<FormState>();
  var description;

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: screenAwareSize(20, 100, context),
            ),
            Container(
              padding: EdgeInsets.only(left: screenAwareSize(10, 8, context)),
              child: Align(
                //alignment: Alignment(-0.7, 0.6),
                child: Text(
                  "Describe why the work was not completed?", //Concatenate the appropriate SERVICE name
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: screenAwareSize(20, 40, context)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: screenAwareSize(15, 30, context),
                  bottom: screenAwareSize(15, 30, context)),
              child: Hero(
                  tag: 'logo',
                  child: Image.asset('assets/images/services.png',
                      width: screenAwareSize(350, 700, context))),
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  selectDropdown(_wizardBloc.serviceSubStatusList, 'Reason'),
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
                              hintText:
                                  'Description of why the work was NOT completed'),
                          onSaved: (value) {
                            //store your value here
                            description = value;
                            // _wizardBloc.selectedService.serviceDescription =
                            //     value;
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

                            // _wizardBloc.addNotesModel(description);
                            _wizardBloc
                                .dispatch(AddWizardNote(noteData: description));

                            if (_wizardBloc.selectedServiceSubStatus
                                    .serviceSubStatusName ==
                                'Requires Additional Work') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: _wizardBloc,
                                    child: ToBeCompleted(),
                                  ),
                                ),
                              );
                            } else if (_wizardBloc.selectedServiceSubStatus
                                    .serviceSubStatusName ==
                                'Part Required') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: _wizardBloc,
                                    child: MajorMinor(),
                                  ),
                                ),
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: _wizardBloc,
                                    child: AdditionalInfomation(),
                                  ),
                                ),
                              );
                            }

                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => BlocProvider.value(
                            //       value: _wizardBloc,
                            //       child: ToBeCompleted(),
                            //     ),
                            //     //   builder: (context) => BlocProvider<WizardBloc>(
                            //     //       builder: (context) => _wizardBloc,
                            //     //       // child: ServiceList(services: orderDetails.order.services),
                            //     //       child: ToBeCompleted()),
                            //   ),
                            // );
//                         save value in database fromhere
//                         bloc.saveValue(description);
                            //  Navigator.pushReplacement(
                            //      context,
                            //         MaterialPageRoute(
                            //          builder: (context) => WizardBlocProvider(
                            //                child: ToBeCompleted(),
                            //              )));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //SelectDropdown dropdown
  selectDropdown(List<ServiceSubStatusModel> dropdownList, type) {
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
                        child: DropdownButton<ServiceSubStatusModel>(
                            hint: Text('Select ' + type),
                            isDense: true,
                            value: _wizardBloc.selectedServiceSubStatus,
                            items:
                                dropdownList.map((ServiceSubStatusModel item) {
                              return DropdownMenuItem<ServiceSubStatusModel>(
                                child: Text(item.serviceSubStatusName),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              state.didChange(value.serviceSubStatusId);
                              _wizardBloc.selectedService.serviceSubStatus =
                                  value.serviceSubStatusName;
                              _wizardBloc.selectedService.serviceSubStatusId =
                                  value.serviceSubStatusId;
                              _wizardBloc.selectedServiceSubStatus = value;
                              // state.didChange(value);
                              // setState(() {
                              //   bloc.reasonDropdownValue = value;
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
