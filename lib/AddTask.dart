import 'package:flutter/material.dart';
import 'package:link2task/API.dart';
import 'package:link2task/models/Globals.dart' as globals;
import 'package:link2task/models/Friend.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddTask extends StatefulWidget {
  @override
  createState() => _AddTask();
}

//Screens definitions*



//Screen classes
class _AddTask extends State {
  //List<String> _taskType = ['Private', 'Public'];
  List<String> _taskStatus = ['Draft', 'Online', 'Archived'];
  List<String> _taskPriority = ['High', 'Medium', 'Low'];
  String _selectedTaskType;
  String _selectedTaskStatus;
  String _selectedTaskPriority;
  var friends = new List<Friend>();

  TextEditingController task_subject_c = new TextEditingController();
  TextEditingController task_content_c = new TextEditingController();
  TextEditingController task_owner_c = new TextEditingController();
  TextEditingController task_type_c = new TextEditingController();
  TextEditingController task_status_c = new TextEditingController();
  TextEditingController task_rating_c = new TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  TimeOfDay time1 = TimeOfDay.now();
  TimeOfDay time2 = TimeOfDay.now();

  String _mySelection;

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
    print("ok");
  }




  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate2)
      setState(() {
        selectedDate2 = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
    initialTime: time1);

    if (picked != null && picked != time1)
      setState(() {
        time1 = picked;
      });
  }

  Future<Null> _selectTime2(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: time2);

    if (picked != null && picked != time2)
      setState(() {
        time2 = picked;
      });
  }


  @override
  void initState() {
    super.initState();
    _getFriends();
  }


  _getFriends() {
    API.getAcceptedRequests(globals.UserId_g).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        friends = list.map((model) => Friend.fromJson(model)).toList();
        return(response.body);
      });
    });
  }

  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ADD TASK"),
        ),
        body:
        SingleChildScrollView(
        child:Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.blueAccent)
                  ),
                  child: TextField(
                    controller: task_subject_c,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 25),
                      labelText: 'Title',
                      contentPadding: EdgeInsets.all(20),
                    ),
                  )
              ),
              Container(
                  decoration: BoxDecoration(
                    //border: Border.all(color: Colors.blueAccent)
                  ),
                  child: TextField(
                    controller: task_content_c,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 25),
                      labelText: 'Description',
                      contentPadding: EdgeInsets.all(20),
                    ),
                  )
              ),
              Text(""),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(child:
                  Column(
                    children: <Widget>[
                      Text("Start date"),
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      Text(time1.hour.toString()+":"+time1.minute.toString()),
                      SizedBox(height: 20.0,),
                      Row(children: <Widget>[
                        RaisedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Set date'),
                        ),
                        RaisedButton(
                          onPressed: () => _selectTime(context),
                          child: Text('Set time'),
                        ),
                      ],)
                  ],
                  ),
                      ),
                   Spacer(),
                   Container(
                     child:
                   Column(
                     children: <Widget>[
                       Text("Finish date"),
                      Text("${selectedDate2.toLocal()}".split(' ')[0]),
                       Text((time2.hour).toString()+":"+time2.minute.toString()),
                      SizedBox(height: 20.0,),
                       Row(children: <Widget>[
                         RaisedButton(
                           onPressed: () => _selectDate2(context),
                           child: Text('Set date'),
                         ),
                         RaisedButton(
                           onPressed: () => _selectTime2(context),
                           child: Text('Set time'),
                         ),
                       ],)
                   ],
                   ),
                   ),
              ]
              )
              ],
              ),
              /*
              DropdownButton(
                hint: Text('Task Type'),
                value: "Private", //_selectedTaskType

                onChanged: (newValue) {
                  setState(() {
                    _selectedTaskType = newValue;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                items: _taskType.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),*/

                new DropdownButton(
                  hint: Text("Assign task"),
                  items: friends.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item.user_one_username, style: TextStyle(color: Colors.black, fontSize: 20)),
                      value: item.user_id,
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _mySelection = newVal;
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                  value: _mySelection,
                ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        child: Text("Cancel"),
                        onPressed: (){
                          Navigator.pop(context);
                        }
                    ),
                    Spacer(),
                    RaisedButton(
                        child: Text("Add task"),
                        onPressed: (){

                          String taskId;

                          API.createTask(task_subject_c.text, 1 , globals.UserId_g, "TESTNIG", task_content_c.text, "0", "${selectedDate.toLocal()}".split(' ')[0] + " " + time1.hour.toString()+":"+time1.minute.toString(),"${selectedDate2.toLocal()}".split(' ')[0] + " " + time2.hour.toString()+":"+time2.minute.toString()).then((response) {
                            setState(() {

                              taskId = jsonDecode(response.body)["id"];
                              print(response.body);
                              if(_mySelection != null) {
                                API.assignTask(
                                    taskId, globals.UserId_g, _mySelection)
                                    .then((response) {

                                  _getNotificationToken(_mySelection, 'New task assigned', globals.UserName_g + ' assigned you new task.');

                                  Navigator.pop(context,"success");
                                  return (response.body);
                                });
                              }
                              else{
                                Navigator.pop(context,"success");
                              }
                            });
                          });

                        }
                    )
                  ]
              )
            ]
        )
        )
    );
  }
}