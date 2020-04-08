import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:flutter/material.dart';



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
        width: screenAwareSize(100, 200, context),
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
