import 'dart:async';


import 'package:etteo_demo/bloc/documents_bloc.dart';
import 'package:etteo_demo/bloc/documents_event.dart';
import 'package:etteo_demo/bloc/documents_state.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/pages/widgets/documents/create_documents.dart';
import 'package:etteo_demo/pages/widgets/documents/documents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentsList extends StatefulWidget {
  final OrderDetailModel orderDetail;

  DocumentsList({@required this.orderDetail});

  @override
  _DocumentsListState createState() => _DocumentsListState();
}

class _DocumentsListState extends State<DocumentsList>
    with AutomaticKeepAliveClientMixin {
  DocumentsBloc _documentsBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _documentsBloc = BlocProvider.of<DocumentsBloc>(context);
    _refreshCompleter = Completer<void>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _documentsBloc = BlocProvider.of<DocumentsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _documentsBloc.orderDetail = widget.orderDetail;
    return BlocListener(
        bloc: _documentsBloc,
        listener: (BuildContext context, DocumentsState state) {
          if (state is DocumentsCreated) {
            Scaffold.of(context).showSnackBar(
                progressSnackBarSuccess('Document creation success'));
          }
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
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
                        headerText("Documents", context),
                        Expanded(
                            child: BlocBuilder(
                          bloc: _documentsBloc,
                          builder:
                              (BuildContext context, DocumentsState state) {
                            if (state is DocumentsForOrderFetching) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return documentListView(
                                widget.orderDetail.order.documents);
                          },
                        ))
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
                              value: _documentsBloc,
                              child: CreateDocument(
                                  orderId: widget.orderDetail.orderId))),
                    );
                  },
                ))));
  }

  Widget documentListView(List<DocumentsModel> documents) {
    return RefreshIndicator(
        onRefresh: () {
          _documentsBloc.dispatch(
            FetchAllDocumentsForOrder(orderId: widget.orderDetail.orderId),
          );
          return _refreshCompleter.future;
        },
        child: documents != null && documents.length > 0
            ? ListView.builder(
                padding: const EdgeInsets.all(0.0),
                itemCount: documents.length,
                itemBuilder: (context, int) {
                  return Container(
                      // margin:
                      //     EdgeInsets.only(top: screenAwareSize(10, 20, context)),
                      child: Documents(document: documents[int]));
                  // child: Documents(document: snapshot.data));
                },
              )
            : Center(
                child: Text(
                  "No documents created yet",
                  style: TextStyle(fontFamily: 'Roboto'),
                ),
              ));
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
