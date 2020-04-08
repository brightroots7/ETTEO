

import 'package:etteo_demo/bloc/documents_bloc.dart';
import 'package:etteo_demo/bloc/documents_event.dart';
import 'package:etteo_demo/bloc/documents_state.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/documents/documents_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CreateDocument extends StatefulWidget {
  final String orderId;
  CreateDocument({@required this.orderId});

  @override
  _CreateDocumentState createState() => _CreateDocumentState();
}

class _CreateDocumentState extends State<CreateDocument>
    with AutomaticKeepAliveClientMixin {
  List<Asset> images = List<Asset>();
  List<DocumentsModel> documents = List();
  String _error = 'No Error Dectected';
  DocumentsBloc documentsBloc;
  String documentDescription;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    documentsBloc = BlocProvider.of<DocumentsBloc>(context)
      ..dispatch(FetchDocumentDropdownValues());
  }

  List<Widget> assetThumbList() {
    List<AssetThumb> at = List<AssetThumb>();
    images.forEach((f) => at.add(AssetThumb(
          asset: f,
          width: 75,
          height: 75,
        )));
    return at;
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          // actionBarColor: "#abcdef",
          // actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Future<void> createDocumentsFromAsset(List<Asset> docs) async {
    List<DocumentsModel> documentList = List();
    DocumentsModel newDocument;
    for (var doc in docs) {
      newDocument = DocumentsModel.fromJson({});
      newDocument.documentType =
          documentsBloc.selectedDocumentType.documentTypeName;
      newDocument.documentTypeId =
          documentsBloc.selectedDocumentType.documentTypeId;
      newDocument.documentDescription = documentDescription;

      newDocument.setFileName(doc.name);
      newDocument.fileLocation =
          await newDocument.getFileLocation(await doc.getByteData(), doc.name);

      // newDocument.fileLocation = doc.name;
      documentList.add(newDocument);
    }

    setState(() {
      documents = documentList;
    });
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                topAppbar(context),
                BlocBuilder(
                    bloc: documentsBloc,
                    builder: (context, state) {
                      if (state is DocumentDropdownValuesFetching) {
                        return showSpinnerInExpanded();
                      }
                      if (state is DocumentDropdownValuesFetched) {
                        return Container(
                          margin:
                              EdgeInsets.all(screenAwareSize(10, 20, context)),
                          child: Card(
                            elevation: 5,
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: screenAwareSize(10, 20, context),
                                  ),

                                  documentTypeDropdown(
                                      documentsBloc.documentTypes,
                                      "Document Type"),
                                  textField(context),
                                  // selectDropdown(
                                  //     serviceBloc.serviceComponents, 'Component'),
                                  SizedBox(
                                    height: screenAwareSize(10, 20, context),
                                  ),

                                  // DocumentPicker(),

                                  Padding(
                                    padding: EdgeInsets.all(
                                        screenAwareSize(14, 28, context)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        button(
                                            context,
                                            'Capture/Upload Photos',
                                            FontAwesomeIcons.camera,
                                            loadAssets),
                                      ],
                                    ),
                                  ),

                                  Wrap(
                                    children:
                                        // Row(
                                        assetThumbList(),
                                    // )
                                  ),

                                  buttons(context),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    }),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding textField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: screenAwareSize(20, 40, context),
            right: screenAwareSize(20, 40, context),
            top: screenAwareSize(15, 30, context),
            bottom: screenAwareSize(15, 30, context)),
        child: TextFormField(
          maxLines: 10,
          minLines: 6,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(screenAwareSize(3, 6, context)),
                gapPadding: 0,
              ),
              hintText: 'Enter description (optional)'),
          onSaved: (value) {
            documentDescription = value;
            //store your value here
          },
        ));
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
            headerText("Add Document", context),
          ],
        )
      ],
    );
  }

  InkWell button(context, name, icon, function) {
    return InkWell(
      child: Card(
        color: Colors.blue,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.only(
              top: screenAwareSize(12, 24, context),
              bottom: screenAwareSize(12, 24, context)),
          width: screenAwareSize(200, 300, context),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
                size: screenAwareSize(20, 40, context),
              ),
              SizedBox(
                height: screenAwareSize(4, 8, context),
              ),
              Text(
                name,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: screenAwareSize(14, 28, context)),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
      onTap: function,
    );
  }

  //SelectDropdown dropdown
  documentTypeDropdown(List<DocumentsTypeModel> dropdownList, type) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenAwareSize(20, 40, context),
          right: screenAwareSize(20, 40, context),
          top: screenAwareSize(15, 30, context),
          bottom: screenAwareSize(15, 30, context)),
      child: FormField<String>(
        validator: (value) {
          if (value == null) {
            return "Select " + type;
          } else {
            return null;
          }
        },
        onSaved: (value) {
          //save data into model here
//       model.service = value;
        },
        builder: (
          FormFieldState<String> state,
        ) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 9,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<DocumentsTypeModel>(
                            hint: Text('Select ' + type),
                            isDense: true,
                            value: documentsBloc.selectedDocumentType,
                            items: dropdownList.map((DocumentsTypeModel item) {
                              return DropdownMenuItem<DocumentsTypeModel>(
                                child: Text(item.documentTypeName),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              state.didChange(value.documentTypeId);
                              // setState(() {
                              documentsBloc.selectedDocumentType = value;
                              // });
                            }),
                      ),
                    )
                  ],
                ),
              ),
              state.hasError
                  ? SizedBox(height: 5.0)
                  : Container(
                      height: 0,
                    ),
              state.hasError
                  ? Text(
                      state.errorText,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.red.shade700,
                          fontSize: screenAwareSize(12, 24, context)),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Padding buttons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenAwareSize(8.0, 16, context)),
      child: Row(
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
            width: screenAwareSize(10, 20, context),
          ),
          Expanded(
            flex: 2,
            child: RaisedButton(
              color: Colors.blue,
              elevation: 5,
              child: Text(
                'Upload',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenAwareSize(13, 26, context)),
              ),
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();

                  await createDocumentsFromAsset(images).then((res) => {
                        if (documents.isNotEmpty)
                          {
                            documentsBloc.dispatch(CreateNewMultipleDocuments(
                                orderId: documentsBloc.orderDetail.orderId,
                                documents: documents)),
                            Navigator.pop(context)
                          }
                      });
                }
              },
            ),
          ),
        ],
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
}
