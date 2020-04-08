

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:etteo_demo/bloc/wizard_bloc.dart';
import 'package:etteo_demo/bloc/wizard_event.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:etteo_demo/pages/widgets/wizard/are_additional_parts_required.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:intl/intl.dart';

class ETA extends StatefulWidget {
  final PartsModel partsModel;

  ETA({@required this.partsModel});

  @override
  _ETAState createState() => _ETAState();
}

class _ETAState extends State<ETA> {
  var formKey = new GlobalKey<FormState>();

  WizardBloc _wizardBloc;

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
            },
          ),
        ],
        leading: new Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: screenAwareSize(20, 40, context),
                  right: screenAwareSize(40, 80, context)),
              child: Align(
                //alignment: Alignment(-0.7, 0.6),
                child: Text(
                  "When do you expect to be able to complete this work?",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: 'SFPro', fontSize: 22),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: screenAwareSize(150, 350, context),
                        left: screenAwareSize(20, 40, context),
                        right: screenAwareSize(20, 40, context)),
                    child: buildDatePickerFormField(context),
                  ),
                  new Container(
                    margin: EdgeInsets.only(
                        top: screenAwareSize(150, 300, context)),
                    child: Align(
                      alignment: Alignment.center,
                      child: ButtonTheme(
                        minWidth: 200.0,
                        child: OutlineButton(
                          child: new Text(
                            "NEXT",
                            style: new TextStyle(
                              fontFamily: 'Roboto',
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 20,
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

                              _wizardBloc.dispatch(AddWizardNote(
                                  noteData:
                                      'Work expected to be completed by ${widget.partsModel.estimatedTimeOfArrival}'));

                              _wizardBloc.dispatch(
                                  AddWizardPart(part: widget.partsModel));

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                      value: _wizardBloc,
                                      child: AdditonalParts()),
                                ),
                                //   builder: (context) => BlocProvider<
                                //           WizardBloc>(
                                //       builder: (context) => _wizardBloc,
                                //       // builder: (context) =>
                                //       //     BlocProvider.of<WizardBloc>(context),
                                //       // child: ServiceList(services: orderDetails.order.services),
                                //       child: AdditonalParts()),
                                // ),
                              );
                            }
                          },
                        ),
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

  final format = DateFormat("yyyy-MM-dd");
  // final formats = {
  //   InputType.date: DateFormat('yyyy-MM-dd'),
  //   InputType.time: DateFormat("h:mma"),
  // };
  bool editable = false;
  DateTimeField buildDatePickerFormField(BuildContext context) {
    return DateTimeField(
      format: format,
      decoration: new InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenAwareSize(5, 10, context)),
        ),
        contentPadding: EdgeInsets.all(0.0),
        labelText: 'Select Date',
        prefixIcon: const Icon(
          Icons.date_range,
        ),
      ),
      onSaved: (value) {
        var _dates = DateFormat('yyyy-MM-dd').format(value);
        widget.partsModel.estimatedTimeOfArrival = _dates;

//        model.date = _dates.toString();
      },
      validator: (value) {
        if (value == null) {
          return ' Date can\'t be empty';
        }
      },
      onShowPicker: (BuildContext context, DateTime currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        return date;
      },
    );
  }
}
