import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:link2task/models/AssignedTask.dart';
import 'package:link2task/DeleteDialog.dart';
import 'package:link2task/EditTask.dart';
import 'package:flutter/material.dart';
import 'package:link2task/API.dart';
import 'package:link2task/models/Globals.dart' as globals;
import 'package:link2task/models/Chat.dart';


class AssignedTaskDetail extends StatefulWidget {
  @override
  final id;
  final assigned_to;
  final assigned_from;
  final subject;
  final content;
  final rating;
  final owner;
  final type;
  final date;

  AssignedTaskDetail(this.id, this.assigned_to, this.assigned_from, this.subject, this.content, this.rating, this.owner, this.type, this.date);
  _AssignedTaskDetail createState() => _AssignedTaskDetail(id, assigned_to, assigned_from, subject, content, rating, owner, type, date);
  }
class _AssignedTaskDetail extends State<AssignedTaskDetail> {
  final id;
  final assigned_to;
  final assigned_from;
  final subject;
  final content;
  final rating;
  final owner;
  final type;
  final date;
  _AssignedTaskDetail(this.id, this.assigned_to, this.assigned_from, this.subject, this.content, this.rating, this.owner, this.type, this.date);

  var chats = new List<Chat>();

  double slider_value;
  TextEditingController _chat_c = new TextEditingController();
  ScrollController _scrollController = new ScrollController();

  _getChats() {
    API.getChat(id, globals.UserId_g).then((response) {
      setState(() {
        print(id);
        Iterable list = json.decode(response.body);
        chats = list.map((model) => Chat.fromJson(model)).toList();

        _scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );

      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getRelationships();
    _getChats();
    slider_value = double.parse(rating);

  }

  TextEditingController task_progress_c = new TextEditingController();


  _updateTask(String task_id, String task_subject, String task_content, String task_type, String task_owner, String task_status, String task_rating) {
    API.updateTask(task_id, task_subject, task_content, task_type, task_owner, task_status, task_rating).then((response) {
      return (response.body);
    });
  }



  _getRelationships() {
    API.getRelationships(globals.UserId_g).then((response) {
      return(response.body);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Row(
                children: <Widget>[
                  Text("Task details"),
                  Spacer(),
                  //Delete task button
                ]
            )
        ),
        body:
            Center(
        child:Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.height,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(),
                  ),
                  color: Colors.blue,
                  margin: EdgeInsets.all(0),
                  elevation: 0,
                  child: ListTile(
                    trailing: Icon(Icons.notifications, size: 60),
                    title: Text(subject, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35)),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Text(content, style: TextStyle(color: Colors.white, fontSize: 20)),
                          Text(
                              "Date created: "+date,
                              style: TextStyle(height: 1, fontSize: 20)
                          ),
                          Text(
                              "Complete: "+ slider_value.toInt().toString() + " %",
                              style: TextStyle(height: 1, fontSize: 20)
                          ),
                          Row(children: <Widget>[
                            Slider(
                            min:0,
                            max: 100,
                            value: slider_value,
                            activeColor: Colors.white,
                            onChanged: (newValue) => {
                              setState(() => slider_value = newValue)
                            },
                          ),
                          RaisedButton(
                              child: Text("Rate"),
                              onPressed: (){
                                _updateTask(id, "", "", "", "", "", slider_value.toInt().toString());

                                API.sendChat(id, globals.UserId_g, owner, "GENERATED", "Task set to: " + slider_value.toInt().toString()+"%" ).then((response) {
                                  setState(() {
                                    _getChats();

                                  });
                                });
                              }
                          )
                          ],
                          )
                      ]
                  )
                )
                ),
              ),
           Expanded(
             child:SizedBox(
               height: 200.0,
               child:
               ListView.builder(
                 controller: _scrollController,
                 shrinkWrap: true,
                 padding: const EdgeInsets.all(0.0),
                 itemCount: chats.length,
                 itemBuilder: (context, index) {
                   return  Container(
                         child: _generateChat(globals.UserId_g, chats, index),
                   );
                 },
               ),
           ),
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
                      API.sendChat(id, globals.UserId_g, owner, subject, _chat_c.text).then((response) {
                        setState(() {
                          _chat_c.text="";
                          _getChats();
                          _scrollController.animateTo(
                            0.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                          FocusScope.of(context).requestFocus(FocusNode());
                        });
                      });
                    }
                )
              ],
              )
            ]
        ),
        )

    );


  }
  Widget _generateChat(String userId, List<Chat> chats, int index){
    if(chats[index].from == userId){
      return ListTile(
          leading: Icon(Icons.supervised_user_circle),
        title: Row(children: <Widget>[
          Text(
            chats[index].message,
            style: TextStyle(fontWeight: FontWeight.bold, height: 0.1, fontSize: 15),
        ),
        ],
           ),
        subtitle: Row(
          children: <Widget>[
            Text("Date: " + chats[index].date,
                style: TextStyle( height: 0.1, fontSize: 13)
            )
          ],
       ),
        onTap: (){

        },
      );
    }
    else{
      return ListTile(
        trailing:
        Icon(Icons.verified_user),
        leading: Text(""),
        title: Row(children: <Widget>[
          Text(
            chats[index].message,
            style: TextStyle(fontWeight: FontWeight.bold, height: 0.1, fontSize: 15),
          ),
        ],
            mainAxisAlignment: MainAxisAlignment.end),
        subtitle: Row(
            children: <Widget>[
              Text("Date: " + chats[index].date,
                  style: TextStyle( height: 0.1, fontSize: 13)
              )
            ],
            mainAxisAlignment: MainAxisAlignment.end),
        onTap: (){

        },
      );
    }
  }
}