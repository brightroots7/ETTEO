import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:etteo_demo/helpers/date_helper.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/helpers/string_helper.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class Documents extends StatelessWidget {
  final DocumentsModel document;
  const Documents({@required this.document});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(screenAwareSize(3.0, 6.0, context)),
        elevation: 5.0,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: getDocumentPreview(),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    titleText(document.documentType, context),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        descriptionText(
                            checkNull(document.documentDescription), context),
                        descriptionText(
                            document.createdDate != null
                                ? getDateTimeFormatted(document.createdDate)
                                : "",
                            context),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        if (await canLaunch(document.fileLocation))
          launch(document.fileLocation);
      },
    );
  }

  Widget getDocumentPreview() {
    if (document.fileLocation != null &&
        document.fileLocation.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: document.fileLocation,
        key: Key(document.documentTypeId),
        useOldImageOnUrlChange: false,
        placeholder: (context, url) => SpinKitPulse(
          size: 35,
          color: Colors.blue,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else {
      return Image(image: FileImage(File(document.fileLocation)));
    }
  }
}

Padding descriptionText(String text, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
        right: screenAwareSize(6, 12, context),
        left: screenAwareSize(6, 12, context)),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: screenAwareSize(15, 30, context),
        color: Colors.black54,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Padding headerText(String text, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: screenAwareSize(4, 8, context)),
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

Padding titleText(String text, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
        top: screenAwareSize(6, 12, context),
        left: screenAwareSize(6, 12, context)),
    child: Text(
      text,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: screenAwareSize(15, 30, context),
          fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
