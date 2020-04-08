import 'package:etteo_demo/bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatefulWidget {
  // const Settings();

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  OfflineBloc _offlineBloc;

  @override
  void initState() {
    _offlineBloc = BlocProvider.of<OfflineBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _offlineBloc,
      builder: (BuildContext context, OfflineState state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
              backgroundColor: Color.fromARGB(200, 12, 49, 110),
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, 1.0),
                child: state is OfflineOperationInProgress
                    ? LinearProgressIndicator(
                        backgroundColor: Colors.white10,
                      )
                    : Container(),
              ),
            ),
            body: Container(
                child: ListView(
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                Title(
                  child: Text(
                    'Offline',
                    style: Theme.of(context).textTheme.title,
                  ),
                  color: Colors.black,
                ),
                ListTile(
                  title: Text('Sync Master Data'),
                  subtitle: Text(
                      'Synchronize master data tables to offline storage. '),
                  onTap: () {
                    _offlineBloc.dispatch(SyncAllMasterTable());
                  },
                ),
                // ListTile(
                //   title: Text('Delete Only Master Data'),
                //   subtitle: Text('Delete all the master data information'),
                //   onTap: () {
                //     Future<ConfirmAction> action = _showDialog(
                //         context, "Delete only master data, Proceed?");
                //     action.then((value) => {
                //           if (ConfirmAction.PROCEED == value)
                //             {_offlineBloc.dispatch(DeleteOfflineMasterData())}
                //         });
                //   },
                // ),
                // ListTile(
                //   title: Text('Delete All Offline Information'),
                //   subtitle: Text(
                //       'Delete all the offline storage data including master data. History of Routes will also be removed.'),
                //   onTap: () {
                //     Future<ConfirmAction> action = _showDialog(context,
                //         "Delete all the offline storage with history of Routes. Want to proceed?");
                //     action.then((value) => {
                //           if (ConfirmAction.PROCEED == value)
                //             {_offlineBloc.dispatch(DeleteAllOfflineData())}
                //         });
                //   },
                // ),
                ListTile(
                  leading: Text('Expire (in days)'),
                  title: TextField(
                    readOnly: true,
                    enabled: false,
                    controller: TextEditingController(text: '7'),
                  ),
                  subtitle: Text('Expiration days for offline data.'),
                  onTap: () {},
                )
              ],
            ))
            // body: Container(
            //   child: ListView.builder(
            //     controller: ScrollController(),
            //     itemCount: items.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text('${items[index]}'),
            //       );
            //     },
            //   ),
            // ),
            );
      },
    );
  }

  Future<ConfirmAction> _showDialog(context, String message) async {
    // flutter defined function
    return await showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm"),
          content: new Text(message +
              '\n' +
              'Please do not close the app until it is completed!!, This process will take a minute.'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("cancel"),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            new FlatButton(
              child: new Text("Proceed"),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.PROCEED);
              },
            ),
          ],
        );
      },
    );
  }
}

enum ConfirmAction { CANCEL, PROCEED }
