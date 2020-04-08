

import 'package:etteo_demo/helpers/date_helper.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_selectable_text/flutter_selectable_text.dart' as fst;

class Notes extends StatelessWidget {
  final NotesModel note;
  const Notes({@required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(screenAwareSize(3.0, 6.0, context)),
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Container(
            //   margin: EdgeInsets.only(right: 16.0),
            //   child: CircleAvatar(
            //       backgroundColor: Colors.blueGrey,
            //       child: Text(note.createdBy != null ? note.createdBy[0] : "")),
            // ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  fst.SelectableText(
                      note.createdBy +
                          ' -- ' +
                          getDateTimeFormatted(note.createdDate),
                      style: Theme.of(context).textTheme.title),
                  fst.SelectableText(note.noteData,
                      style: Theme.of(context).textTheme.subhead),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
