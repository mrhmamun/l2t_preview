import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:link2task/models/Task.dart';
import 'package:link2task/DeleteDialog.dart';
import 'package:link2task/EditTask.dart';
import 'package:flutter/material.dart';
import 'package:link2task/API.dart';
import 'package:link2task/models/Friend.dart';
import 'package:link2task/models/Globals.dart' as globals;
import 'package:dash_chat/dash_chat.dart';
import 'package:http/http.dart' as http;
import 'package:link2task/models/Chat.dart';

class TaskDetail extends  StatefulWidget{
  final Task task;
  TaskDetail(this.task);
  _TaskDetail createState() => _TaskDetail(task);
}

class _TaskDetail extends State<TaskDetail> {
  final Task task;

  _TaskDetail(this.task);

  TextEditingController friend_id_c = new TextEditingController();

  var friends = new List<Friend>();
  var _mySelection;
  TextEditingController _chat_c = new TextEditingController();

  var chats = new List<Chat>();


  _getChats() {
    API.getChat(task.id, globals.UserId_g).then((response) {
      setState(() {
        print(task.id);
        print(response.body);
        Iterable list = json.decode(response.body);
        chats = list.map((model) => Chat.fromJson(model)).toList();
      });
    });
  }

  _getFriends() {
    API.getAcceptedRequests(globals.UserId_g).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        friends = list.map((model) => Friend.fromJson(model)).toList();
        print(response.body);
      });
    });
  }

  _getNotificationToken(String userId, String body, String title) {
    API.getNotificationToken(userId).then((response) {
      setState(() {
        print("Notification posted.");
        _postNotification(jsonDecode(response.body)['TOKEN'], body, title);
      });
    });
  }

  _postNotification(String to, String body, String title) async {
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
    print("Notification posted to " + to.toString());
  }


  _assignTask(String task_id, String assigned_from, String assigned_to) {
    API.assignTask(task_id, assigned_from, assigned_to).then((response) {
      _getNotificationToken(_mySelection, 'New task assigned',
          globals.UserName_g + ' assigned you new task.');

      return (response.body);
    });
  }


  _getRelationships() {
    API.getRelationships(globals.UserId_g).then((response) {
      return (response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    _getChats();
    _getFriends();
  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Row(
                children: <Widget>[
                  Text("Task details"),
                  Spacer(),
                  //Delete task button
                  IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(context,
                            new MaterialPageRoute(
                                builder: (context) => EditTask(task))
                        );
                      }
                  ),
                  IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      color: Colors.white,
                      onPressed: () {
                        showDeleteDialog(context, task.id); //confirm delete
                      }
                  )
                ]
            )
        ),
        body:
        Column(
            children: <Widget>[
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(),
                  ),
                  color: Colors.blue,
                  margin: EdgeInsets.all(0),
                  elevation: 13,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        trailing: Icon(Icons.notifications, size: 60),
                        title: Text(task.subject, style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35)),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(task.content, style: TextStyle(color: Colors
                                  .white, fontSize: 20)),
                              Text("", style: TextStyle(color: Colors.black,
                                  fontSize: 20)),
                              Row(children: <Widget>[
                                new DropdownButton(
                                  hint: Text("Select friend"),
                                  items: friends.map((item) {
                                    return new DropdownMenuItem(
                                      child: new Text(item.user_one_username,
                                          style: TextStyle(color: Colors.black,
                                              fontSize: 20)),
                                      value: item.user_id,
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      _mySelection = newVal;
                                    });
                                  },
                                  value: _mySelection,
                                ),
                                RaisedButton(
                                    child: Text("Assign task"),
                                    onPressed: () {
                                      _assignTask(task.id, globals.UserId_g,
                                          _mySelection);

                                      API.sendChat(task.id, globals.UserId_g, task.owner, "GENERATED", "Task was assigned." ).then((response) {
                                        setState(() {
                                          _getChats();

                                        });
                                      });

                                    }
                                ),
                              ],
                              ),
                              Text("Start date: " + task.start_date),
                              Text("End date:   " + task.end_date)
                            ]
                        ),
                      ),
                   ],
                  ),
                ),
              ),
              Expanded(
              child:SizedBox(
              height: 200.0,
              child:
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0.0),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: _generateChat(
                        globals.UserId_g, chats, index),
                  );
                },
              )
              )
              ),
              Row(children: <Widget>[
                new Flexible(
                    child: new TextField(
                        controller: _chat_c,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter chat text'
                        )
                    )
                ),
                IconButton(
                    icon: Icon(Icons.send, color: Colors.blue),
                    color: Colors.white,
                    onPressed: () {
                      API.sendChat(task.id, globals.UserId_g, task.owner, task.subject, _chat_c.text).then((response) {
                        setState(() {
                          _chat_c.text="";
                          _getChats();
                          FocusScope.of(context).requestFocus(FocusNode());
                        });
                      });
                    }
                )
              ],
              )
          ]
        )
    );
  }

  Widget _generateChat(String userId, List<Chat> chats, int index) {
    if (chats[index].from == userId) {
      return ListTile(
        leading:  Icon(Icons.supervised_user_circle),
        title: Row(children: <Widget>[
          Text(
            chats[index].message,
            style: TextStyle(
                fontWeight: FontWeight.bold, height: 0.1, fontSize: 15),
          ),
        ],
            ),
        subtitle: Row(
            children: <Widget>[
              Text("Date: " + chats[index].date,
                  style: TextStyle(height: 0.1, fontSize: 13)
              )
            ],
            ),
        onTap: () {

        },
      );
    }
    else {
      return ListTile(
        trailing:
        Icon(Icons.verified_user),
        leading: Text(""),
        title: Row(children: <Widget>[
          Text(
            chats[index].message,
            style: TextStyle(
                fontWeight: FontWeight.bold, height: 0.1, fontSize: 15),
          ),
        ],
            mainAxisAlignment: MainAxisAlignment.end),
        subtitle: Row(
            children: <Widget>[
              Text("Date: " + chats[index].date,
                  style: TextStyle(height: 0.1, fontSize: 13)
              )
            ],
            mainAxisAlignment: MainAxisAlignment.end),
        onTap: () {

        },
      );
    }
  }
}