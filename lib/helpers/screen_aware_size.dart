import 'package:flutter/material.dart';

double baseHeight = 640;
// to make the ui responsive we are using this function,it will adjust the screen elements for all screensizes
double screenAwareSize(double portraitsize,double landscapesize, BuildContext context){
  if(MediaQuery.of(context).orientation == Orientation.portrait){
    return portraitsize * MediaQuery.of(context).size.height / baseHeight;
  }else{
    return landscapesize * MediaQuery.of(context).size.height / baseHeight;
  }
}