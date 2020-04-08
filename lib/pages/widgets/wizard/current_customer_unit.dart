import 'package:etteo_demo/bloc/wizard_bloc.dart';
import 'package:etteo_demo/bloc/wizard_event.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:etteo_demo/pages/widgets/wizard/current_unit_photo.dart';


import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';



class CustomerCurrentlyHas extends StatefulWidget {
  @override
  _CustomerCurrentlyHasState createState() => _CustomerCurrentlyHasState();
}

class _CustomerCurrentlyHasState extends State<CustomerCurrentlyHas> {
  WizardBloc _wizardBloc;
  var formKey = new GlobalKey<FormState>();
  var description;
  PartsModel _partsModel;

  @override
  Widget build(BuildContext context) {
    _partsModel = PartsModel.fromJson({});
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
          children: <Widget>[
            SizedBox(
              height: screenAwareSize(20, 40, context),
            ),
            Container(
              padding: EdgeInsets.only(left: screenAwareSize(10, 8, context)),
              child: Align(
                //alignment: Alignment(-0.7, 0.6),
                child: Text(
                  "What doest the customer currently have?", //Concatenate the appropriate SERVICE name
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: screenAwareSize(20, 40, context)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenAwareSize(20, 40, context)),
              child: Hero(
                  tag: 'logo',
                  child: Image.asset('assets/images/services.png',
                      width: screenAwareSize(350, 700, context))),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    titleText('Make', context),
                    textField('Make', context),
                    titleText('Model', context),
                    textField('Model', context),
                    titleText('Serial Number', context),
                    textField('Serial Number', context),
                  ],
                ),
              ),
            ),
            new Container(
              child: Align(
                alignment: Alignment.center,
                child: ButtonTheme(
                  minWidth: 200.0,
                  child: OutlineButton(
                    child: new Text(
                      "NEXT",
                      style: new TextStyle(
                        fontFamily: 'Roboto',
                        color: Theme.of(context).brightness == Brightness.light
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

                        _partsModel.unitType = _wizardBloc
                            .defaultPartTypeCurrentUnit.unitTypeDescription;
                        _partsModel.unitTypeId =
                            _wizardBloc.defaultPartTypeCurrentUnit.unitTypeId;

                        _partsModel.unitStatus = _wizardBloc
                            .defaultPartStatusOnLocation.unitStatusDescription;
                        _partsModel.unitStatusId = _wizardBloc
                            .defaultPartStatusOnLocation.unitStatusId;

                        _wizardBloc.dispatch(AddWizardPart(part: _partsModel));

                        //save data into database by calling this function

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BlocProvider<WizardBloc>.value(
                                      value: _wizardBloc,
                                      child: CurrentUnitPhoto(),
                                    )));
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenAwareSize(20, 40, context),
            ),
          ],
        ),
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

  Padding textField(String title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenAwareSize(6.0, 12.0, context)),
      child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(screenAwareSize(3, 6, context)),
              gapPadding: 0,
            ),
            hintText: 'Enter ' + title,
            contentPadding: EdgeInsets.all(
              screenAwareSize(10, 20, context),
            ),
          ),
          onSaved: (value) {
            if (title == 'Model') {
              _partsModel.model = value;
            } else if (title == 'Make') {
              _partsModel.make = value;
            } else if (title == 'Serial Number') {
              _partsModel.serialNumber = value;
            }
            //store your value here
//            if(title == 'Model'){
//              model.model = value;
//            }else if (title == 'Make'){
//              model.make = value;
//            }
          },
          validator: (value) {
            if (value.isEmpty) {
              return '$title can\'t be empty';
            } else {
              return null;
            }
          }),
    );
  }
}
