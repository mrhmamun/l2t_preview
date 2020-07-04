import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:calendar_views/day_view.dart';
import 'package:link2task/API.dart';
import 'utils/all.dart';
import 'dart:convert';
import 'package:link2task/models/Task.dart';
import 'package:link2task/models/Globals.dart' as globals;
import 'package:link2task/TaskDetail.dart';
import 'package:link2task/AssignedTaskDetail.dart';
import 'package:link2task/calendar/CalendarView.dart';


@immutable
class Event {
  Event({
    @required this.startMinuteOfDay,
    @required this.duration,
    @required this.title,
    @required this.id
  });

  final int startMinuteOfDay;
  final int duration;
  final String title;
  final int id;
}
//List<Event> eventsOfDay0;


List<Event> eventsOfDay0 = <Event>[
 /* new Event(startMinuteOfDay: 0, duration: 60, title: "TASK 1, TASK2, TASK3 ..."),
  new Event(startMinuteOfDay: 0, duration: 120, title: "TASK4"),
  new Event(
      startMinuteOfDay: 6 * 60, duration: 2 * 60, title: "TEST TASK 2"),
  new Event(startMinuteOfDay: 6 * 60, duration: 60, title: "TEST TASK 3"),
  new Event(startMinuteOfDay: 7 * 60, duration: 60, title: "TEST TASK 4"),
  new Event(startMinuteOfDay: 7 * 60, duration: 60, title: "TEST TASK 14"),
  new Event(startMinuteOfDay: 7 * 60, duration: 60, title: "TEST TASK 24"),
  new Event(
      startMinuteOfDay: 18 * 60, duration: 60, title: "TEST TASK 6"),*/
];






class DayViewExample extends StatefulWidget {
  @override
  State createState() => new _DayViewExampleState();
}

class _DayViewExampleState extends State<DayViewExample> {
  DateTime _day0;
  DateTime _day1;
  var tasks = new List<Task>();
  int loading = 0;

  _getTasks()  {
    API.getDashboardTasks(globals.UserId_g).then((response) {
        Iterable list = json.decode(response.body);
        tasks = list.map((model) => Task.fromJson(model)).toList();
        loading = 1;
        setState(() {
        });
        return tasks;
    });
  }

  _monthView() {
    Navigator.pop(context);
    Navigator.push(context, new MaterialPageRoute(builder: (context)=>MyHomePage()));
  }

  Future getAllTasksFuture;

  @override
  void initState() {
    super.initState();
    this.getAllTasksFuture = _getTasks();

    _day0 = new DateTime.now();
    _day1 = _day0.toUtc().add(new Duration(days: 1)).toLocal();


  }

  String _minuteOfDayToHourMinuteString(int minuteOfDay) {
    return "${(minuteOfDay ~/ 60).toString().padLeft(2, "0")}"
        ":"
        "${(minuteOfDay % 60).toString().padLeft(2, "0")}";
  }

  List<StartDurationItem> _getEventsOfDay(DateTime day) {
    List<Event> events;
    if (day.year == _day0.year &&
        day.month == _day0.month &&
        day.day == _day0.day) {
      events = eventsOfDay0;
    }

    return events
        .map(
          (event) => new StartDurationItem(
        startMinuteOfDay: event.startMinuteOfDay,
        duration: event.duration,
        builder: (context, itemPosition, itemSize) => _eventBuilder(
          context,
          itemPosition,
          itemSize,
          event,
        ),
      ),
    )
        .toList();
  }


  _calculateDuration(String start_time, String end_time){

    int output;

    int year1= int.parse(start_time.split(" ")[0].split("-")[0]);
    int month1= int.parse(start_time.split(" ")[0].split("-")[1]);
    int day1= int.parse(start_time.split(" ")[0].split("-")[2]);

    int hour1 = int.parse(start_time.split(" ")[1].split(":")[0]);
    int minute1 = int.parse(start_time.split(" ")[1].split(":")[1]);

    int year2= int.parse(end_time.split(" ")[0].split("-")[0]);
    int month2= int.parse(end_time.split(" ")[0].split("-")[1]);
    int day2= int.parse(end_time.split(" ")[0].split("-")[2]);
    int hour2 = int.parse(end_time.split(" ")[1].split(":")[0]);
    int minute2 = int.parse(end_time.split(" ")[1].split(":")[1]);


    if(year1 > 0 && year2 > 0) {
      final date1 = DateTime(year1, month1, day1, hour1, minute1);
      final date2 = DateTime(year2, month2, day2, hour2, minute2);
      final difference = date2.difference(date1).inMinutes;
      output = difference;
    }
    else{
      output = 1440;
    }

    return output.abs();
  }

  _calculateMinute(String time){
    int hour = int.parse(time.split(" ")[1].split(":")[0]);
    int minute = int.parse(time.split(" ")[1].split(":")[1]);
    int output;
    bool up;

    if(hour > 12){
      hour = (hour)-12;
      up = true;
    }
    else{
      hour=(hour);
      up = false;
    }

    if(up) {
      output = hour * 60 + minute + (12*60); //pm
    }
    else{
      output = hour * 60 + minute; //am
    }

    return output.abs();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          children: <Widget>[
            Text("Day View"),
            Spacer(),
            //Refresh button
            IconButton(
              color: Colors.white,
              onPressed: _monthView,
              icon: Icon(Icons.calendar_today),
            ),
            IconButton(
              color: Colors.white,
              onPressed: _getTasks,
              icon: Icon(Icons.refresh),
            ),
          ],
        )
      ),
      body:  new FutureBuilder(
        future: getAllTasksFuture,
          builder: (context, AsyncSnapshot snapshot) {


    if (loading == 1) {


      eventsOfDay0.clear();
      for(int i=0; i<tasks.length; i++) {

        print(tasks[i].start_date.split(" ")[0]);
        print(_day0.toString().split(" ")[0]);

    if(tasks[i].start_date.split(" ")[0] ==_day0.toString().split(" ")[0]) {
      eventsOfDay0.addAll(<Event>[
        new Event(
            startMinuteOfDay: _calculateMinute(tasks[i].start_date.toString()),
            duration: _calculateDuration(
                tasks[i].start_date, tasks[i].end_date),
            title: tasks[i].subject,
            id: i
        )
      ]);
    }

      }

        return _wholePage(tasks);
    }
    else
    return Text("Loading...");
          }
      )
    );
  }

    Widget _wholePage(List<Task> tasks) {
     return new DayViewEssentials(
      properties: new DayViewProperties(
        days: <DateTime>[
          _day0,
          /*_day1,
            _day1,*/
        ],
      ),
      child: new Column(
        children: <Widget>[
          new Container(
            color: Colors.grey[200],
            child: new DayViewDaysHeader(
              headerItemBuilder: _headerItemBuilder,
            ),
          ),
          new Expanded(
            child: new SingleChildScrollView(
              child: new DayViewSchedule(
                heightPerMinute: 1.0,
                components: <ScheduleComponent>[
                  new TimeIndicationComponent.intervalGenerated(
                    generatedTimeIndicatorBuilder:
                    _generatedTimeIndicatorBuilder,
                  ),
                  new SupportLineComponent.intervalGenerated(
                    generatedSupportLineBuilder: _generatedSupportLineBuilder,
                  ),
                  new DaySeparationComponent(
                    generatedDaySeparatorBuilder:
                    _generatedDaySeparatorBuilder,
                  ),
                  new EventViewComponent(
                    getEventsOfDay: _getEventsOfDay,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _headerItemBuilder(BuildContext context, DateTime day) {
    return new Container(
      color: Colors.grey[300],
      padding: new EdgeInsets.symmetric(vertical: 4.0),
      child: new Column(
        children: <Widget>[
          new Text(
            "${weekdayToAbbreviatedString(day.weekday)}",
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
          new Text("${day.day}"),
        ],
      ),
    );
  }

  Positioned _generatedTimeIndicatorBuilder(
      BuildContext context,
      ItemPosition itemPosition,
      ItemSize itemSize,
      int minuteOfDay,
      ) {
    return new Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width,
      height: itemSize.height,
      child: new Container(
        child: new Center(
          child: new Text(_minuteOfDayToHourMinuteString(minuteOfDay)),
        ),
      ),
    );
  }

  Positioned _generatedSupportLineBuilder(
      BuildContext context,
      ItemPosition itemPosition,
      double itemWidth,
      int minuteOfDay,
      ) {
    return new Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemWidth,
      child: new Container(
        height: 0.7,
        color: Colors.grey[700],
      ),
    );
  }

  Positioned _generatedDaySeparatorBuilder(
      BuildContext context,
      ItemPosition itemPosition,
      ItemSize itemSize,
      int daySeparatorNumber,
      ) {
    return new Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width,
      height: itemSize.height,
      child: new Center(
        child: new Container(
          width: 0.7,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned _eventBuilder(
      BuildContext context,
      ItemPosition itemPosition,
      ItemSize itemSize,
      Event event,
      ) {
    return new Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width,
      height: itemSize.height,
      child:
        new GestureDetector(
        onTap: (){
          if(tasks[event.id].owner == globals.UserId_g){
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>TaskDetail(tasks[event.id])));
          }
          else{
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>AssignedTaskDetail(tasks[event.id].id, "", "", tasks[event.id].subject, tasks[event.id].content, tasks[event.id].rating, tasks[event.id].owner, tasks[event.id].type, tasks[event.id].date)));
          }
    },
    child:
      new Container(
        margin: new EdgeInsets.only(left: 1.0, right: 1.0, bottom: 1.0),
        padding: new EdgeInsets.all(3.0),
        color: Colors.orange,
        child: new Text("${event.title}"),
      ),
    )
    );
  }
}