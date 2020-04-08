

import 'package:etteo_demo/bloc/wizard_bloc.dart';
import 'package:etteo_demo/bloc/wizard_event.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/pages/widgets/wizard/photo_button.dart';
import 'package:etteo_demo/pages/widgets/wizard/what_part_is_needed.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class CurrentDataPlatePhoto extends StatefulWidget {
  @override
  _CurrentDataPlatePhotoState createState() => _CurrentDataPlatePhotoState();
}

class _CurrentDataPlatePhotoState extends State<CurrentDataPlatePhoto> {
  WizardBloc _wizardBloc;

  List<Asset> images = List<Asset>();
  List<DocumentsModel> documents = List();
  String _error = 'No Error Dectected';

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

    for (Asset doc in docs) {
      newDocument = DocumentsModel.fromJson({});
      newDocument.documentType =
          _wizardBloc.defaultDocumentTypeDataPlate.documentTypeName;
      newDocument.documentTypeId =
          _wizardBloc.defaultDocumentTypeDataPlate.documentTypeId;

      newDocument.setFileName(doc.name);
      newDocument.fileLocation =
          await newDocument.getFileLocation(await doc.getByteData(), doc.name);

      print(newDocument);

      // newDocument.fileLocation = await doc.metadata.then((value) => );
      documentList.add(newDocument);
    }

    setState(() {
      documents = documentList;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.only(left: screenAwareSize(10, 20, context)),
              child: Align(
                //alignment: Alignment(-0.7, 0.6),
                child: Text(
                  "Attach a photo of the current data plate", //Concatenate the appropriate SERVICE name
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: screenAwareSize(20, 40, context)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: screenAwareSize(20, 40, context),
                  bottom: screenAwareSize(20, 40, context)),
              child: Hero(
                  tag: 'logo',
                  child: Image.asset('assets/images/parts.png',
                      width: screenAwareSize(350, 700, context))),
            ),
            new Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(screenAwareSize(8, 16, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        button(context, 'Camera/Upload Photos',
                            FontAwesomeIcons.camera, loadAssets),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Wrap(
              children:
                  // Row(
                  assetThumbList(),
              // )
            ),
            new Container(
              margin: EdgeInsets.only(top: screenAwareSize(50.0, 100, context)),
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
                    onPressed: images.isNotEmpty
                        ? () async {
                            await createDocumentsFromAsset(images)
                                .then((res) => {
                                      if (documents.isNotEmpty)
                                        {
                                          _wizardBloc.dispatch(
                                              AddWizardMultipleDocument(
                                                  documents: documents)),
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider<
                                                          WizardBloc>.value(
                                                        value: _wizardBloc,
                                                        child: PartNeeded(),
                                                      )))
                                        }
                                    });
                          }
                        : () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
