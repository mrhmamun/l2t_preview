import 'package:flutter/material.dart';
import 'package:link2task/API.dart';
import 'package:link2task/models/Relationship.dart';
import 'package:link2task/models/Globals.dart' as globals;
import 'dart:convert';
import 'package:flushbar/flushbar.dart';


class MyFriends extends StatefulWidget {
  @override
  createState() => _AddFriends();
}

class _AddFriends extends State {
  TextEditingController username_c = new TextEditingController();
  var relationship = new List<Relationship>();

  _getMyFriends() {
    API.getAcceptedRequests(globals.UserId_g).then((response) {
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
    _getMyFriends();
  }

  dispose() {
    super.dispose();
  }

  build(context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(3, 159, 216, 100),
          title: Text("MY FRIENDS"),
        ),
        body:

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
             Expanded(
                child:
                SizedBox(
                    height: 200.0,
                    child:
                    ListView.builder(
                      itemCount: relationship.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Card(
                            child:
                          Row(children: <Widget>[
                            Text(" "),
                            Icon(Icons.verified_user,
                            color: Colors.green,),
                            Text(
                              " "+relationship[index].user_one_username,
                              style: TextStyle(height: 1, fontSize: 25)
                          ),
                            Spacer(),/*
                            IconButton(
                              color: Color.fromRGBO(3, 159, 216, 100),
                              onPressed: _getMyFriends,
                              icon: Icon(Icons.message),
                            ),
                            IconButton(
                              color: Color.fromRGBO(3, 159, 216, 100),
                              onPressed: _getMyFriends,
                              icon: Icon(Icons.delete),
                            )*/
                          ],
                          )
                         ),
                        );
                      },
                    )
                )
            )
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
