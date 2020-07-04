import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link2task/API.dart';
import 'package:link2task/AddTask.dart';
import 'package:link2task/calendar/day_view.dart';
import 'package:link2task/models/AssignedTask.dart';
import 'dart:convert';
import 'package:link2task/models/Task.dart';
import 'package:link2task/TaskDetail.dart';
import 'package:link2task/calendar/CalendarView.dart';
import 'package:link2task/models/Globals.dart' as globals;
import 'package:link2task/AddFriends.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:link2task/AssignedTaskDetail.dart';


class MyTaskScreen extends StatefulWidget {
  @override
  _MyTaskScreen createState() => _MyTaskScreen();
}

class _MyTaskScreen extends State<MyTaskScreen> {
  var tasks = new List<Task>();



  var assigned_tasks = new List<AssignedTask>();

  _getTasks() {
    API.getDashboardTasks(globals.UserId_g).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        tasks = list.map((model) => Task.fromJson(model)).toList();
      });
    });
  }

  _calendarView() {
   Navigator.push(context, new MaterialPageRoute(builder: (context)=>DayViewExample()));
  }

  _getUsername(String user_id) {
    API.GetUsernameByUserId(user_id).then((response) {
      return(jsonDecode(response.body)["USERNAME"]);
    });
  }

  _getColor(String rating){
    int percent = int.parse(rating);
    if(percent == 0){
      return Colors.grey;
    }
    else if(percent > 0 && percent <= 49){
      return Colors.redAccent;
    }
    else if(percent >= 50 && percent <= 90) {
      return Colors.deepOrangeAccent;
    }
    else if(percent == 100) {
      return Colors.green;
    }
    else{
      return Colors.grey;
    }
  }

  _getDirection(String owner){
    if(owner == globals.UserId_g){
      return Icons.arrow_forward;
    }
    else{
      return Icons.arrow_back;
    }
  }

  _getDirectionColor(String owner){
    if(owner == globals.UserId_g){
      return Color.fromRGBO(73, 200, 84, 1);
    }
    else{
      return Color.fromRGBO(200, 73, 84, 1);
    }
  }

  _AddTask(BuildContext context) async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTask()),
    );

    if("$result" == "success"){
      showSuccessFlushbar(context, "Task was succesfuly created.", "$result");
      _getTasks();//refresh screen
    }
    else if("$result" == "fail"){
      showErrorFlushbar(context, "Task was not created.", "$result");
    }


  }

  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(3, 159, 216, 100),
          title:Row(
            children: <Widget>[
              Text("MY TASKS"),
              Spacer(),
              //Refresh button
              IconButton(
                color: Colors.white,
                onPressed: _calendarView,
                icon: Icon(Icons.timer),
              ),
              IconButton(
                color: Colors.white,
                onPressed: _getTasks,
                icon: Icon(Icons.refresh),
              ),
            ],
          )
      ),
      backgroundColor: Color(0xFF05A0DA),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)])),
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 38,
                          color: Color(0xffffffff),
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 20),
                              blurRadius: 50,
                              color: const Color(0xff000000).withOpacity(0.16),
                            ),
                          ],
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Link',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF05A0DA))),
                          TextSpan(
                              text: '2',
                              style: TextStyle(
                                  color: Color(0xffFFBE04),
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: 'Task',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF05A0DA)))

                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 400,
                      height: MediaQuery.of(context).size.height / 2+5,
                      margin: const EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 20),
                            blurRadius: 50,
                            color: const Color(0xff000000).withOpacity(0.16),
                          )
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  left: 3.0,
                                  top: 0.0,
                                  bottom: 0.0,
                                  right: 3.0),
                              alignment: Alignment.centerLeft,
                              height: MediaQuery.of(context).size.height / 2+5 ,
                              child: Scrollbar(
                                  child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(0.0),
                                itemCount: tasks.length,
                                itemBuilder: (context, index) {
                                  return  Container(
                                    child:Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(13.0),
                                        ),
                                    child:ListTile(
                                      trailing:
                                        Icon(_getDirection(tasks[index].owner),
                                      color: _getDirectionColor(tasks[index].owner),
                                      ),
                                      leading: CircularPercentIndicator(
                                        radius: 50.0,
                                        lineWidth: 4.0,
                                        percent: 1.0,
                                        center: new Text(tasks[index].rating + "%"),
                                        progressColor: _getColor(tasks[index].rating),
                                      ),
                                    title: Text(
                                        tasks[index].subject,
                                        style: TextStyle(fontWeight: FontWeight.bold, height: 0.1, fontSize: 15)
                                    ),
                                    subtitle: Row(
                                      children: <Widget>[
                                        Text("Date: " + tasks[index].date,
                                            style: TextStyle( height: 0.1, fontSize: 13)
                                        ),
                                       /* Icon(Icons.notification_important,//delete
                                        color:  Colors.red,
                                        size: 15
                                        )*/
                                      ],
                                    ),
                                    onTap: (){
                                        if(tasks[index].owner == globals.UserId_g){
                                          Navigator.push(context, new MaterialPageRoute(builder: (context)=>TaskDetail(tasks[index])));
                                        }
                                        else{
                                          Navigator.push(context, new MaterialPageRoute(builder: (context)=>AssignedTaskDetail(tasks[index].id, "", "", tasks[index].subject, tasks[index].content, tasks[index].rating, tasks[index].owner, tasks[index].type, tasks[index].date)));
                                        }

                                    },
                                  ),
                                  ),
                                  );
                                },
                              )
                          ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        _AddTask(context);
                      },
                      child:
                      Container(
                        width: 170,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(70),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 20),
                              blurRadius: 50,
                              color: const Color(0xff000000).withOpacity(0.16),
                            )
                          ],
                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.montserrat(
                                fontSize: 38,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Add task!',
                                    style: TextStyle(
                                        color: Color(0xff3a3a3a),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        shadows: [
                                          Shadow(
                                            offset: const Offset(0, 20),
                                            blurRadius: 50,
                                            color: const Color(0xff000000)
                                                .withOpacity(0.16),
                                          )
                                        ])
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            overflow: Overflow.visible,
          ),
        ),
      ),
    );
  }



}
