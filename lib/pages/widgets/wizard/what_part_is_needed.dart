

import 'package:etteo_demo/bloc/wizard_bloc.dart';
import 'package:etteo_demo/bloc/wizard_event.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:etteo_demo/pages/widgets/wizard/are_additional_parts_required.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';


class PartNeeded extends StatefulWidget {
  @override
  _PartNeededState createState() => _PartNeededState();
}

class _PartNeededState extends State<PartNeeded> {
  WizardBloc _wizardBloc;
  PartsModel _newPartModel = PartsModel.fromJson({});
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
            },
          ),
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
              height: screenAwareSize(20, 100, context),
            ),
            Container(
              padding: EdgeInsets.only(left: screenAwareSize(10, 8, context)),
              child: Align(
                //alignment: Alignment(-0.7, 0.6),
                child: Text(
                  "What part is needed", //Concatenate the appropriate SERVICE name
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
                  new Container(
                    margin: EdgeInsets.all(screenAwareSize(25, 50, context)),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                          maxLines: 10,
                          minLines: 6,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    screenAwareSize(5, 6, context)),
                                gapPadding: 0,
                              ),
                              hintText: 'Enter the part information'),
                          onSaved: (value) {
                            //store your value here
                            description = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Part description can\'t be empty';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                  ButtonTheme(
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
                          // save value in database fromhere
                          // bloc.saveValue(description);

                          // Create new part.
                          _newPartModel.unitStatus = _wizardBloc
                              .defaultPartStatusRequested.unitStatusDescription;
                          _newPartModel.unitStatusId = _wizardBloc
                              .defaultPartStatusRequested.unitStatusId;

                          _newPartModel.unitType = _wizardBloc
                              .defaultPartTypeRequested.unitTypeDescription;
                          _newPartModel.unitTypeId =
                              _wizardBloc.defaultPartTypeRequested.unitTypeId;
                          _newPartModel.unitDescription = description;

                          _wizardBloc
                              .dispatch(AddWizardPart(part: _newPartModel));

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: _wizardBloc,
                                child: AdditonalParts(),
                              ),
                            ),
                          );
                          // AdditonalParts()));
                        }
                      },
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
}
