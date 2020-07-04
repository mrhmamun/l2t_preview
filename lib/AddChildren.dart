import 'package:flutter/material.dart';
import 'package:link2task/API.dart';
import 'package:link2task/models/Relationship.dart';
import 'package:link2task/models/Globals.dart' as globals;
import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class AddChildren extends StatefulWidget {
  @override
  createState() => _AddChildren();
}

class _AddChildren extends State {
  TextEditingController username_c = new TextEditingController();
  TextEditingController password_c = new TextEditingController();
  TextEditingController email_c = new TextEditingController();
  TextEditingController phone_number_c = new TextEditingController();

  var relationship = new List<Relationship>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  _getRelationshipRequests() {
    API.getRelationshipRequests(globals.UserId_g).then((response) {
      setState(() {
        if(true/*dodaj preverjanje statusa webservica*/) {
          Iterable list = json.decode(response.body);
          relationship = list.map((model) => Relationship.fromJson(model)).toList();
        }
        else {
          //izpis obestila!
          print("No new friend requests");
        }
      });
    });
  }

  _setRelationship(String user_two_id, String operation) {
    API.setRelationship(globals.UserId_g, user_two_id, operation).then((response) {
    });
  }



  initState() {
    super.initState();
    _getRelationshipRequests();
  }

  dispose() {
    super.dispose();
  }

  build(context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(3, 159, 216, 100),
          title: Text("ADD CHILD TO PROFILE"),
        ),
        body:

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              controller: username_c,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 25),
                labelText: 'Enter usename / phone number',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            TextField(
              controller: email_c,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 25),
                labelText: 'Enter Email',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            TextField(
              controller: phone_number_c,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 25),
                labelText: 'Phone number',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            TextField(
              controller: password_c,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 25),
                labelText: 'Enter Password',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            RaisedButton(
                child: Text("Add child"),
                onPressed: (){
                    String Token;
                    _firebaseMessaging.getToken().then((token) {
                    Token=(token); // Print the Token in Console

                    API.signUp(
                        email_c.text, password_c.text, username_c.text,
                        phone_number_c.text, globals.UserId_g, token).then((response) {
                      setState(() {
                        if(jsonDecode(response.body)["status"]){
                          //Signup successfull
                          showSuccessFlushbar(context, "Signup successful.", jsonDecode(response.body)["message"]);


                        }else{
                          //Signup failed
                          showErrorFlushbar(context, "Signup failed.", jsonDecode(response.body)["message"]);
                        }
                      });
                    });
                    });
                }
            ),
          ],
        )
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
    duration: Duration(seconds: 3),
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
    duration: Duration(seconds: 3),
  )..show(context);
}
