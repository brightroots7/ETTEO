

import 'package:etteo_demo/bloc/notes_bloc.dart';
import 'package:etteo_demo/bloc/notes_event.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNote extends StatefulWidget {
  final String orderId;
  CreateNote({@required this.orderId});

  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote>
    with AutomaticKeepAliveClientMixin {
  NotesBloc notesBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    notesBloc = BlocProvider.of<NotesBloc>(context);
  }

  final _noteTextController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Container(
            child: Form(
                key: formKey,
                child: Container(
                  child: LayoutBuilder(builder: (BuildContext context,
                      BoxConstraints viewportConstraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            topAppbar(context),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      screenAwareSize(14, 28, context)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      titleText('Note', context),
                                      textField(context),
                                      SizedBox(
                                        height:
                                            screenAwareSize(10, 20, context),
                                      ),
                                      buttons(context)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                    );
                  }),
                ))));
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
            headerText("Add Note", context),
          ],
        )
      ],
    );
  }

  TextFormField textField(BuildContext context) {
    return TextFormField(
        maxLines: 10,
        minLines: 6,
        controller: _noteTextController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(screenAwareSize(3, 6, context)),
              gapPadding: 0,
            ),
            hintText: 'Enter Note'),
        onSaved: (value) {
          //store your value here
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Notes can\'t be empty';
          } else {
            return null;
          }
        });
  }

  Align titleText(String text, BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(
            left: screenAwareSize(6.0, 12.0, context),
            bottom: screenAwareSize(8.0, 16, context)),
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

  Row buttons(BuildContext context) {
    return Row(
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
          width: screenAwareSize(15, 30, context),
        ),
        Expanded(
          flex: 2,
          child: RaisedButton(
            color: Colors.blue,
            elevation: 5,
            child: Text(
              'ADD NOTE',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenAwareSize(13, 26, context)),
            ),
            onPressed: () {
              if (formKey.currentState.validate()) {
                formKey.currentState.save();

                String noteDate = DateTime.now().toUtc().toString();

                NotesModel newNote = NotesModel.fromJson({
                  'createdBy': AppConfig().userProfile.fullName,
                  'noteData': _noteTextController.text,
                  'createdDate': noteDate
                });

                //call the addfunction in _notesBloc from here
                notesBloc.dispatch(
                    CreateNewNote(orderId: widget.orderId, note: newNote));

                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ],
    );
  }
}
