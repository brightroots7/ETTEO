

import 'package:etteo_demo/custome/custome_button.dart';
import 'package:etteo_demo/pages/access_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartServicePage extends StatefulWidget {
  @override
  _StartServicePageState createState() => _StartServicePageState();
}

class _StartServicePageState extends State<StartServicePage> {


  @override
  void initState(){
  super.initState();
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
}

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Scaffold(
     body:  Stack(
        children: <Widget>[
          Positioned(
            top: 60,
            left: 20,
            child: Container(
             child: Text("You have arrived!",style: TextStyle(fontSize:size.height/28),),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height/10,),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height/4,
                  width:MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/Map.png")
                    )
                  ),
                ),
              ),
              SizedBox(height: size.height/10,),
              CustomRoundedButton(
                text: "  Start\nService",
                callback: navigateToNextPage
              )
            ],
          ),
          Positioned(
            top: 20,
            right: 15,
            child: IconButton(
              icon: Icon(Icons.close,color:Colors.black)
            , onPressed: (){
              Navigator.of(context).pop();
            })
            )
        ],
      ),
    );
  }
  void navigateToNextPage(){
    print("Navigate to next page");
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AccessHomePage()));
   }
}