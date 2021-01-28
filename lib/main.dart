import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nolik/home_screen.dart';
import 'package:nolik/constants/constants.dart';
import 'package:nolik/ui/signin.dart';
import 'package:nolik/ui/signup.dart';
import 'package:nolik/ui/menu.dart';


void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>{
      '/splashscreen': (BuildContext context) =>  SplashScreen(),
      '/HomeScreen': (BuildContext context) => new HomeScreen(),
      MENU: (BuildContext context) => new AnimalQuiz() ,
      SIGN_IN: (BuildContext context) =>  SignInPage(),
      SIGN_UP: (BuildContext context) =>  SignUpScreen(),
    },
    initialRoute: '/splashscreen',
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // Navigator.of(context).pushReplacementNamed('/HomeScreen');
    Navigator.of(context).pushReplacementNamed(SIGN_IN);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: new Text("Welcome"),
             ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(" To The NoLik E.C.D Center"),
              ) ,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Image.asset(
                  'images/splash.jpg',
                  width: 200,
                  height: 200,
                ),
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: new Text("ICT E-LEARNING"),
               ) ,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text("PLATFORM"),
              ) ,
              new Container(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: new CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
