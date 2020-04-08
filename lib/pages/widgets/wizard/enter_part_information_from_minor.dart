

import 'package:etteo_demo/bloc/wizard_bloc.dart';
import 'package:etteo_demo/bloc/wizard_event.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:etteo_demo/pages/widgets/wizard/eta.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';


class PartInformationMinor extends StatefulWidget {
  @override
  _PartInformationMinorState createState() => _PartInformationMinorState();
}

class _PartInformationMinorState extends State<PartInformationMinor> {
  WizardBloc _wizardBloc;
  var formKey = new GlobalKey<FormState>();
  var description;

  PartsModel newPartModel;

  @override
  Widget build(BuildContext context) {
    _wizardBloc = BlocProvider.of<WizardBloc>(context);
    newPartModel = PartsModel.fromJson({});
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
              height: screenAwareSize(20, 40, context),
            ),
            Container(
              padding: EdgeInsets.only(left: screenAwareSize(10, 8, context)),
              child: Align(
                //alignment: Alignment(-0.7, 0.6),
                child: Text(
                  "Enter part information", //Concatenate the appropriate SERVICE name
                  textAlign: TextAlign.center,
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
                  child: Image.asset('assets/images/parts.png',
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
                            newPartModel.unitDescription = value;
                            if (value.isEmpty) {
                              return 'Part information can\'t be empty';
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
                        newPartModel.unitTypeId =
                            _wizardBloc.defaultPartTypeSupplied.unitTypeId;
                        newPartModel.unitType = _wizardBloc
                            .defaultPartTypeSupplied.unitTypeDescription;
                        newPartModel.unitStatus = _wizardBloc
                            .defaultPartStatusRequested.unitStatusDescription;
                        newPartModel.unitStatusId =
                            _wizardBloc.defaultPartStatusRequested.unitStatusId;

                        newPartModel.unitDescription = description;

                        // _wizardBloc.addNotesModel(
                        //   " New Unit Created: ${newPartModel.unitDescription} Type = ${newPartModel.unitType}");

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: _wizardBloc,
                              child: ETA(
                                partsModel: newPartModel,
                              ),
                            ),
                            // builder: (context) => BlocProvider<WizardBloc>(
                            //     builder: (context) => _wizardBloc,
                            //     // builder: (context) =>
                            //     //     BlocProvider.of<WizardBloc>(context),
                            //     // child: ServiceList(services: orderDetails.order.services),
                            //     child: ETA(
                            //       partsModel: newPartModel,
                            //     )),
                          ),
                        );
                        //  if (formKey.currentState.validate()) {
                        //    formKey.currentState.save();
//                         save value in database fromhere
//                         bloc.saveValue(description);
                        //    Navigator.pushReplacement(
                        //        context,
                        //        MaterialPageRoute(
                        //            builder: (context) => ServiceBlocProvider(
                        //                  child: ETA(),
                        //                )));
                        //  }
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
