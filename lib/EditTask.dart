import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:link2task/models/Task.dart';
import 'package:link2task/API.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class EditTask extends StatefulWidget {
  @override
  final Task task;
  EditTask(this.task);
  createState() => _EditTask(this.task);
}

class _EditTask extends State {
  final Task task;
  _EditTask(this.task);

  TextEditingController _subject_c = new TextEditingController();
  TextEditingController _content_c = new TextEditingController();

  _updateTask(String task_id, String task_subject, String task_content, String task_type, String task_owner, String task_status, String task_rating) {
    API.updateTask(task_id, task_subject, task_content, task_type, task_owner, task_status, task_rating).then((response) {
      return (response.body);
    });
  }



  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Task"),
        ),
        body: Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.blueAccent)
                  ),
                  child: TextField(
                    controller: _subject_c,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 25),
                      labelText: 'Task subject',
                      helperText: task.subject,
                      contentPadding: EdgeInsets.all(20),
                    ),
                  )
              ),
              Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.blueAccent)
                  ),
                  child: TextField(
                    controller: _content_c,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 25),
                      labelText: 'Task content',
                      helperText: task.content,
                      contentPadding: EdgeInsets.all(20),
                    ),
                  )
              ),
              Row(
                  children: <Widget>[
                    RaisedButton(
                        child: Text("Cancel"),
                        onPressed: (){
                          Navigator.pop(context);
                        }
                    ),
                    RaisedButton(
                        child: Text("Apply changes"),
                        onPressed: (){
                          _updateTask(task.id, _subject_c.text, _content_c.text, "", "", "", "");
                          Navigator.pop(context);
                        }
                    )
                  ]
              )
            ]
        )
    );
  }
}