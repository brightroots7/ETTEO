import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

/// Splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String animationName = 'Untitled'; 

  @override
  Widget build(BuildContext context) {
    return Container(
      // mainAxisAlignment: MainAxisAlignment.start,
      color: Colors.white,
      width: 500,
      height: 500,
      child: FlareActor(
        'assets/E.flr',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: animationName,
      ),

    );
  }
}
