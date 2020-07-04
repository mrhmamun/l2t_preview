import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'WelcomePage.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:link2task/models/Globals.dart' as globals;
import 'package:link2task/models/message.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _animationName = "spinner";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];




  @override
  void initState() {

    print("Notifications enabled.");

    _firebaseMessaging.getToken().then((token) {
      print(token); // Print the Token in Console
    });

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));


    super.initState();



    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => WelcomeScreen())));


  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Color(0xFF05A0DA),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF05A0DA), Color(0xFF016185)])),
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            child: FlareActor(
              'assets/spinner.flr',
              animation: _animationName,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
