import 'package:flutter/material.dart';

class CustomBorderRoundedButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  CustomBorderRoundedButton({Key key, this.callback, this.text}) :super(key:key);
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width:MediaQuery.of(context).size.width,
      child: Material(
        borderRadius: BorderRadius.circular(30),
        shadowColor: Colors.grey,
        elevation:2,
        color: Colors.white,
        child: InkWell(
          onTap: callback,
          child: Container(
            width:MediaQuery.of(context).size.width/2.3,
             decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
        
            alignment:Alignment.center,
              height: MediaQuery.of(context).size.height/14,
            child:  Text(text.toUpperCase(), style: TextStyle(color:callback != null?Colors.black87 :Colors.grey,fontSize: size.height/40,fontWeight: FontWeight.bold),),
          ),
        ),
      )
    );
  }
}

class CustomRoundedButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  CustomRoundedButton({Key key, this.callback, this.text}) :super(key:key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width:MediaQuery.of(context).size.width,
      child: MaterialButton(
        elevation: 5,
        onPressed:callback,
        color: Colors.white,
        textColor: Colors.white,
        child: Container(
          alignment:Alignment.center,
            height: MediaQuery.of(context).size.height/5.5,
          child:  Text(text, style: TextStyle(color:Colors.black,fontSize: size.height/35),),
        ),
        shape: CircleBorder(),
      )
    );
  }
}

/*
Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.blue,
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200,
          height: 45,
          child: Text(text, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
 */