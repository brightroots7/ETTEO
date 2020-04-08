import 'package:flutter/material.dart';

/// Snack bar for info type
Widget progressSnackBarInfo(String text,) {
  return SnackBar(
    duration: Duration(seconds: 5),
    content: Text(text),
    backgroundColor: Colors.grey[700],
    behavior: SnackBarBehavior.fixed,
  );
}

showDialogBox(BuildContext context, String resonse){
  showDialog(
    context: context,
    builder: (context)=>AlertDialog(
     title: Text("Response Token"),
     content: Text(resonse),
     )
    );
}

Widget pushNotifySnackBar(String text, Function actionEventFunction) {
  return SnackBar(
    duration: Duration(seconds: 5),
    content: Text(text),
    backgroundColor: Colors.grey[400],
    behavior: SnackBarBehavior.fixed,
    action: SnackBarAction(
      label: 'UPDATE',
      onPressed: () => actionEventFunction(),
    ),
  );
}

Widget progressSnackBarSuccess(String text) {
  return SnackBar(
    duration: Duration(milliseconds: 500),
    content: Text(text),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.fixed,
  );
}

///  Snack bar for error type
Widget progressSnackBarError(String text) {
  return SnackBar(
    content: Text(text),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.fixed,
  );
}

Widget showSpinner() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget showSpinnerInExpanded() {
  return Expanded(
    child: showSpinner(),
  );
}

/// Error that will not proceed further on app.
Widget fatalError(String text) {
  return Scaffold(
    body: Center(
        child: Text(text,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.red[200]))),
  );
}
