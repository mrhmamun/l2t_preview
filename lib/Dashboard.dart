import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link2task/AddChildren.dart';
import 'package:link2task/MyTaskScreen.dart';
import 'package:link2task/AddFriends.dart';
import 'package:link2task/MyFriends.dart';
import 'package:flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  PageController _pageController;
  int currentIndex = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          showNotificationFlushbar(context, "New task arrived.", "You just recieved a new task.");

        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        setState(() {

        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Color(0xFF05A0DA),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          MyTaskScreen(),
          MyFriends(),
          AddFriends(),
          AddChildren(),
        ],
      ),
    );
  }



}

void showErrorFlushbar(BuildContext context, String title, String message) {
  Flushbar(
    title: title,
    message: message,
    icon: Icon(
      Icons.error,
      size: 28,
      color: Colors.redAccent,
    ),
    leftBarIndicatorColor: Colors.redAccent,
    duration: Duration(seconds: 4),
  )..show(context);
}

void showSuccessFlushbar(BuildContext context, String title, String message) {
  Flushbar(
    title: title,
    message: message,
    icon: Icon(
      Icons.check,
      size: 28,
      color: Colors.blue,
    ),
    leftBarIndicatorColor: Colors.blue,
    duration: Duration(seconds: 7),
  )..show(context);
}

void showNotificationFlushbar(BuildContext context, String title, String message) {
  Flushbar(
    title: title,
    message: message,
    icon: Icon(
      Icons.notification_important,
      size: 28,
      color: Colors.orangeAccent,
    ),
    leftBarIndicatorColor: Colors.orange,
    duration: Duration(seconds: 3),
  )..show(context);
}
