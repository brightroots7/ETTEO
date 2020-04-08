import 'package:etteo_demo/bloc/wizard_bloc.dart';
import 'package:etteo_demo/bloc/wizard_event.dart';
import 'package:etteo_demo/bloc/wizard_state.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AdditionalInfomation extends StatefulWidget {
  @override
  _AdditionalInfomationState createState() => _AdditionalInfomationState();
}

class _AdditionalInfomationState extends State<AdditionalInfomation> {
  WizardBloc _wizardBloc;
  var formKey = new GlobalKey<FormState>();
  ProgressDialog pr;

  var description;

  @override
  void initState() {
    pr = new ProgressDialog(context, showLogs: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _wizardBloc = BlocProvider.of<WizardBloc>(context);

    return BlocListener(
        bloc: _wizardBloc,
        listener: (BuildContext context, WizardState state) {
          if (state is WizardCompleting) {
            // pr.update(message: 'processing...');
            // : print('not showing');
            pr.show();
            // updateProgress(pr: pr, message: 'processing...');
          }

          if (state is WizardProgress) {
            // updateProgress(pr: pr, message: state.message);
            // pr.show();
            if (pr.isShowing()) {
              pr.update(message: state.message);
            }
            // pr.update(message: state.message);

            // ?
            // : print('notshowing');

            // pr.show();
            // updateProgress(pr: pr, message: state.message, percentage: state.percentage);
          }
          if (state is WizardProgressDone) {
            // updateProgress(pr: pr, message: 'completed');
            // pr.isShowing()
            //     ? pr.update(message: 'completed successfully')
            //     : print('notshowing');
            // pr.show();
            pr.hide();
            Navigator.pop(context);
          }
        },
        child: BlocBuilder(
            bloc: _wizardBloc,
            builder: (BuildContext context, WizardState state) {
              return Scaffold(
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
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
                        padding: EdgeInsets.only(
                            left: screenAwareSize(10, 8, context)),
                        child: Align(
                          //alignment: Alignment(-0.7, 0.6),
                          child: Text(
                            "Enter any additional notes", //Concatenate the appropriate SERVICE name
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'SFPro',
                                fontSize: screenAwareSize(20, 40, context)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: screenAwareSize(30, 60, context)),
                        child: Hero(
                            tag: 'logo',
                            child: Image.asset('assets/images/notes.png',
                                width: screenAwareSize(200, 400, context))),
                      ),
                      SizedBox(
                        height: screenAwareSize(20, 40, context),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            new Container(
                              margin: EdgeInsets.all(
                                  screenAwareSize(25, 50, context)),
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
                                        hintText: 'Enter additonal notes'),
                                    onSaved: (value) {
                                      //store your value here
                                      description = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Additonal notes can\'t be empty';
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
                                  "COMPLETE",
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
                                  color:
                                      Color(0xffa6b2c1), //Color of the border
                                  style:
                                      BorderStyle.solid, //Style of the border
                                  width: 1.0, //width of the border
                                ),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();

                                    _wizardBloc.dispatch(
                                        AddWizardNote(noteData: description));
                                    // _wizardBloc.addNotesModel(description);
                                    pr.show();
                                    _wizardBloc.dispatch(WizardComplete());
//                         save value in database fromhere
//                         bloc.saveValue(description);
                                    // Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ),
                            new InkWell(
                                child: new Text('No Additional Notes Needed',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    )),
                                onTap: () {
                                  _wizardBloc.dispatch(
                                      AddWizardNote(noteData: description));
                                  // _wizardBloc.addNotesModel(description);
                                  pr.show();
                                  _wizardBloc.dispatch(WizardComplete());
//                         save value in database fromhere
//                         bloc.saveValue(description);
                                  // Navigator.of(context).pop();
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
