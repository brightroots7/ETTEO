
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:flutter_signature_pad/flutter_signature_pad.dart';


class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => new _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  List<Offset> _points = <Offset>[];


 ByteData _img = ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>(); 

  @override
  void dispose() {
   SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
   ]);
    super.dispose();
  }

  @override
  void initState() {
  SystemChrome.setPreferredOrientations([
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
  ]);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left :20.0, right: 20, top:20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Signature",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20),),
            Text("By signing below,you acknowledge that you have been shown all items listed and aprrove the status of each",
            style: TextStyle(fontSize: MediaQuery.of(context).size.height/50),),
            SizedBox(height: MediaQuery.of(context).size.height/50,),
            Center(
              child: new Container(
                height: MediaQuery.of(context).size.height/1.5,
                //width:  MediaQuery.of(context).size.width/1.1,
                child: DottedBorder(
                color: Colors.black,
                  // gap: 3,
                  strokeWidth: 1,
                  child: 
                  Signature(
                  color: Colors.blue,
                  key: _sign,
                  onSign: () {
                    final sign = _sign.currentState;
                    debugPrint('${sign.points.length} points in the signature');
                  },
                  backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                  strokeWidth: strokeWidth,
                ),
                  
                  // new GestureDetector(
                  //   onPanUpdate: (DragUpdateDetails details) {
                  //     setState(() {
                  //       RenderBox object = context.findRenderObject();
                  //       Offset _localPosition =
                  //           object.globalToLocal(details.globalPosition);
                  //       _points = new List.from(_points)..add(_localPosition);
                  //     });
                  //   },
                  //   onPanEnd: (DragEndDetails details) => _points.add(null),
                  //   child: new CustomPaint(
                  //     painter: new Signature(points: _points),
                  //     size: Size.infinite,
                  //   ),
                  // ),
                ),
              ),
            ),
             
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[

          Material(
            borderRadius: BorderRadius.circular(30),
            elevation: 2,
            color: Colors.white,
            child: InkWell(
              onTap: () {
                final sign = _sign.currentState;
                sign.clear();
                setState(() {
                  _img = ByteData(0);
                });
                debugPrint("cleared");
              },  
              child: Container(
                 decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                width:MediaQuery.of(context).size.width/5,
                alignment:Alignment.center,
                  height: MediaQuery.of(context).size.height/9,
                child:  Text("CLEAR",),
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width/7,),
           Material(
            borderRadius: BorderRadius.circular(30),
            elevation: 2,
            color: Colors.white,
            child: InkWell(
              onTap: ()async{
                final sign = _sign.currentState;
                //retrieve image data, do whatever you want with it (send to server, save locally...)
                final image = await sign.getData();
                var data = await image.toByteData(format: ui.ImageByteFormat.png);
                sign.clear();
                final encoded = base64.encode(data.buffer.asUint8List());
                setState(() {
                  _img = data;
                });
                debugPrint("onPressed " + encoded);
              }, 
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                width:MediaQuery.of(context).size.width/5,
                alignment:Alignment.center,
                  height: MediaQuery.of(context).size.height/9,
                child:  Text("COMPLETE",),
              ),
            ),
          ),
          
          
        //    new FloatingActionButton.extended(
        //      heroTag: "complete",
        //    backgroundColor: Colors.white,
        //     onPressed: (){}, 
        //     label: Text("COMPLETE",style: TextStyle(color: Colors.black),),
        //   ),
        ],
      )
    );
  }
}

// class Signature extends CustomPainter {
//   List<Offset> points;

//   Signature({this.points});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = new Paint()
//       ..color = Colors.blue
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 5.0;

//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null) {
//         canvas.drawLine(points[i], points[i + 1], paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
// }




class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    // canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8, Paint()..color = Colors.pink);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _WatermarkPaint && runtimeType == other.runtimeType && price == other.price && watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}
