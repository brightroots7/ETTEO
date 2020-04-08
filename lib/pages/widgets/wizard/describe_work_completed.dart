import 'package:etteo_demo/bloc/wizard_bloc.dart';
import 'package:etteo_demo/bloc/wizard_event.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/pages/widgets/wizard/did_you_supply_parts.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';


class WorkCompleted extends StatefulWidget {
  @override
  _WorkCompletedState createState() => _WorkCompletedState();
}

class _WorkCompletedState extends State<WorkCompleted> {
  var formKey = new GlobalKey<FormState>();
  var description;

  @override
  Widget build(BuildContext context) {
    WizardBloc _wizardBloc = BlocProvider.of<WizardBloc>(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
              color: Colors.black,
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
                  "Describe the work that was completed", //Concatenate the appropriate SERVICE name
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
                              hintText: 'Description of work completed'),
                          onSaved: (value) {
                            description = value;
                            //store your value here
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
                  ButtonTheme(
                    minWidth: 200.0,
                    child: OutlineButton(
                      child: new Text(
                        "NEXT",
                        style: new TextStyle(
                          fontFamily: 'Roboto',
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

                          _wizardBloc
                              .dispatch(AddWizardNote(noteData: description));

                          /// Redirect to SupplyParts()
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<WizardBloc>.value(
                                value: _wizardBloc,
                                child: SupplyParts(),
                              ),
                            ),
                          );
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
