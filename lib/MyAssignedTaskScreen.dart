import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link2task/API.dart';
import 'package:link2task/AddTask.dart';
import 'dart:convert';
import 'package:link2task/models/AssignedTask.dart';
import 'package:link2task/TaskDetail.dart';
import 'package:link2task/models/Globals.dart' as globals;
import 'package:link2task/AddFriends.dart';
import 'package:link2task/AssignedTaskDetail.dart';
import 'package:percent_indicator/percent_indicator.dart';



class MyAssignedTaskScreen extends StatefulWidget {
  @override
  _MyAssignedTaskScreen createState() => _MyAssignedTaskScreen();
}

class _MyAssignedTaskScreen extends State<MyAssignedTaskScreen> {
  var tasks = new List<AssignedTask>();

  _getAssignedTasks() {
    API.getAssignedTasks(globals.UserId_g).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        tasks = list.map((model) => AssignedTask.fromJson(model)).toList();
      });
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



  @override
  void initState() {
    super.initState();
    _getAssignedTasks();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(3, 159, 216, 100),
          title:Row(
            children: <Widget>[
              Text("TASKS ASSIGNED TO ME"),
              Spacer(),
              //Refresh button
              IconButton(
                color: Colors.white,
                onPressed: _getAssignedTasks,
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
                  colors: [Color(0xFF05A0DA), Color(0xFF016185)])),
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
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: '2',
                              style: TextStyle(
                                  color: Color(0xffFFBE04),
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: 'Task',
                              style: TextStyle(fontWeight: FontWeight.bold))

                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 400,
                      height: MediaQuery.of(context).size.height / 2,
                      margin: const EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(24),
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
                          Text("TASKS ASSIGNED TO ME"),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  top: 1.0,
                                  bottom: 10.0,
                                  right: 10.0),
                              alignment: Alignment.centerLeft,
                              height: MediaQuery.of(context).size.height / 2 -16,
                              child: ListView.builder(
                                itemCount: tasks.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading:
                                     CircularPercentIndicator(
                                      radius: 50.0,
                                      lineWidth: 4.0,
                                      percent: 1.0,
                                      center: new Text(tasks[index].rating + "%"),
                                      progressColor: _getColor(tasks[index].rating),
                                    )
                                    ,
                                    title: Text(
                                        tasks[index].subject,
                                        style: TextStyle(fontWeight: FontWeight.bold,height: 1, fontSize: 30)
                                    ),
                                    subtitle: Row(
                                      children: <Widget>[
                                        Text("Assigned by: " + tasks[index].assigned_from),
                                        Text(" || " + tasks[index].date),
                                      ],
                                    ),
                                    onTap: (){
                                     /* Navigator.push(context,
                                          new MaterialPageRoute(builder: (context)=>AssignedTaskDetail(tasks[index])));*/
                                    },
                                  );
                                },
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
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
