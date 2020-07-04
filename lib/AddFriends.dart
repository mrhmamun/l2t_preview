import 'package:flutter/material.dart';
import 'package:link2task/API.dart';
import 'package:link2task/models/Relationship.dart';
import 'package:link2task/models/Globals.dart' as globals;
import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class AddFriends extends StatefulWidget {
  @override
  createState() => _AddFriends();
}

class _AddFriends extends State {
  TextEditingController username_c = new TextEditingController();
  var relationship = new List<Relationship>();

  _getNotificationToken(String userId, String body, String title){
    API.getNotificationToken(userId).then((response) {
      setState(() {
        print("Notification posted.");
        _postNotification(jsonDecode(response.body)['TOKEN'], body, title);
      });
    });
  }

  _postNotification(String to, String body, String title) async{
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAAExwV-7k:APA91bEdcEqUrT37XMipRzTc5e-mIYRwQ3J-8dU-vo1cGGUd9q_QiJDAsRzgfgqiKK_-K40xE7MhbSn82U7VphXaeAHBXfD1Aedc58M4Lqxu8RGZhDpVZ7qROX1Kdh-OiTIdBPfS_G4M',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': to,
        },
      ),
    );
  }

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
          title: Text("FRIENDSHIP REQUESTS"),
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
                    labelText: 'Enter usename',
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
                RaisedButton(
                    child: Text("Add friend"),
                    onPressed: (){
                      API.GetUserIdByUsername(username_c.text).then((response) {
                        if(json.decode(response.body)["STATUS"] == true){
                          API.setRelationship(globals.UserId_g, json.decode(response.body)["USER_ID"] , "0").then((response_two) {
                            if(json.decode(response_two.body)["status"]){
                              showSuccessFlushbar(context, "Success", "Your friend request was sent successfuly.");
                            }else{
                              //izpis obvestila
                              showErrorFlushbar(context, "Friend request failed", "Relationship is not set.");
                            }

                          });

                          //IZPIS OBVESTILA!! PROSNJA ZA PRIJATELJSTVO POSLANA
                        }
                        else{
                          showErrorFlushbar(context, "Friend request failed", "Username doesn't exist.");
                        }

                      });
                    }
                ),
        Text('My friend requests (tap to accept):',
          style: TextStyle(fontWeight: FontWeight.bold),),
        Expanded(
          child:
                SizedBox(
            height: 200.0,
                child:
            ListView.builder(
          itemCount: relationship.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  relationship[index].user_one_username,
                  style: TextStyle(fontWeight: FontWeight.bold,height: 1, fontSize: 30)
              ),
              subtitle: Row(
                children: <Widget>[
                  //Text("Date: " + tasks[index].date),
                ],
              ),
              onTap: (){
                _setRelationship(relationship[index].action_user_id, "1");
                showSuccessFlushbar(context, "Success", "Friendship request was accepted.");

              },
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
