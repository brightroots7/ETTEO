

import 'package:etteo_demo/bloc/notes_bloc.dart';
import 'package:etteo_demo/bloc/notes_state.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/pages/widgets/notes/create_note.dart';
import 'package:etteo_demo/pages/widgets/notes/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesList extends StatefulWidget {
  final OrderDetailModel orderDetail;

  NotesList({@required this.orderDetail});

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList>
    with AutomaticKeepAliveClientMixin {
  NotesBloc _notesBloc;

  @override
  void initState() {
    super.initState();
    _notesBloc = BlocProvider.of<NotesBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _notesBloc.orderDetailModel = widget.orderDetail;
    return BlocListener(
        bloc: _notesBloc,
        listener: (BuildContext context, NotesState state) {
          if (state is NotesCreated) {
            Scaffold.of(context).showSnackBar(
                progressSnackBarSuccess('Notes creation success'));
          }
        },
        child: Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: EdgeInsets.all(screenAwareSize(10, 20, context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        headerText("Notes", context),
                        Expanded(
                            child: BlocBuilder(
                          bloc: _notesBloc,
                          builder: (BuildContext context, NotesState state) {
                            if (state is NotesCreating) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return noteListView(widget.orderDetail.order.notes);
                          },
                        )),
                      ],
                    ))),
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                              value: _notesBloc,
                              child: CreateNote(
                                  orderId: widget.orderDetail.orderId))),
                    );
                  },
                ))));
  }

  Widget noteListView(List<NotesModel> notes) {
    return notes != null && notes.length > 0
        ? ListView.builder(
            padding: const EdgeInsets.all(0.0),
            itemCount: notes.length,
            itemBuilder: (context, int) {
              return Container(
                  // margin:
                  //     EdgeInsets.only(top: screenAwareSize(10, 20, context)),
                  child: Notes(note: notes[int]));
              // child: Notes(note: snapshot.data));
            },
          )
        : Center(
            child: Text("No notes created yet"),
          );
  }

  @override
  bool get wantKeepAlive => true;
}

Padding headerText(String text, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
        left: screenAwareSize(3.0, 6.0, context),
        bottom: screenAwareSize(3, 6, context)),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: screenAwareSize(20, 40, context),
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
