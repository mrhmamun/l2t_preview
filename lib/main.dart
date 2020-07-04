import 'dart:convert';
import 'package:link2task/API.dart';
import 'package:link2task/MyTaskScreen.dart';
import 'package:link2task/models/User.dart';
import 'package:link2task/models/Task.dart';
import 'package:link2task/AddTask.dart';
import 'package:link2task/EditTask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:link2task/SplashScreen.dart';

import 'Login.dart';

void main() => runApp(MyApp());

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
var initializationSettingsAndroid =
new AndroidInitializationSettings('app_icon');



class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LINK2TAKS PREVIEW 1',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyTaskScreen(),
    );
  }
}

