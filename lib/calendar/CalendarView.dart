import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:link2task/calendar/day_view.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:link2task/API.dart';
import 'dart:convert';
import 'package:link2task/models/Task.dart';
import 'package:link2task/models/Globals.dart' as globals;

import 'package:link2task/TaskDetail.dart';
import 'package:link2task/AssignedTaskDetail.dart';






var tasks = new List<Task>();

void main() {
  initializeDateFormatting().then((_) => runApp(MyHomePage()));
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Map<DateTime, List> _events = new Map<DateTime,List>();
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  final _selectedDay = DateTime.now();


  Future getAllTasksFuture;
  int loading = 0;


  @override
  void initState() {
    super.initState();
    this.getAllTasksFuture = _getTasks();



    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();

      }

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

  _taskView() {
    Navigator.pop(context);

  }


  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
   setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text("Day View"),
            Spacer(),
            //Refresh button
            IconButton(
              color: Colors.white,
              onPressed: _taskView,
              icon: Icon(Icons.view_agenda),
            ),
            IconButton(
              color: Colors.white,
              onPressed: _getTasks,
              icon: Icon(Icons.refresh),
            ),
          ],
        )
      ),
      body:new FutureBuilder(
          future: getAllTasksFuture,
          builder: (context, AsyncSnapshot snapshot) {
            List tasks_day = new List();

            print(loading);
            
            if (loading == 1) {

                for (int i = 0; i < tasks.length; i++) {

                  if( _events[DateTime(int.parse(tasks[i].start_date.split("-")[0]),int.parse(tasks[i].start_date.split("-")[1]),int.parse(tasks[i].start_date.split("-")[2].split(" ")[0]))]==null){
                    tasks_day = [tasks[i].subject];
                    _events[DateTime(int.parse(tasks[i].start_date.split("-")[0]),int.parse(tasks[i].start_date.split("-")[1]),int.parse(tasks[i].start_date.split("-")[2].split(" ")[0]))]=tasks_day;
                  }
                  else{
                    tasks_day.add(tasks[i].subject);
                    _events[DateTime(int.parse(tasks[i].start_date.split("-")[0]),int.parse(tasks[i].start_date.split("-")[1]),int.parse(tasks[i].start_date.split("-")[2].split(" ")[0]))]=tasks_day;
                  }


                }

                loading=3; //done loading

              return _wholePage(tasks);
            }
            else if(loading == 0){
              return Text("Loading");
            }
            else{
              return _wholePage(tasks);
            }
          }
      )
    );
  }

  Widget _wholePage(List<Task> tasks){
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        // Switch out 2 lines below to play with TableCalendar's settings
        //-----------------------
        _buildTableCalendar(),
        // _buildTableCalendarWithBuilders(),
        const SizedBox(height: 8.0),
        _buildButtons(),
        const SizedBox(height: 8.0),
        Expanded(child: _buildEventList()),
      ],
    );
  }


  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blue[400],
        todayColor: Colors.blueAccent[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.lightBlue[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
 //   final dateTime = _events.keys.elementAt(_events.length);

    return Column(
      children: <Widget>[
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: ()  {

/*
          if(tasks[event.id].owner == globals.UserId_g){
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>TaskDetail(tasks[event.id])));
        }
        else{
        Navigator.push(context, new MaterialPageRoute(builder: (context)=>AssignedTaskDetail(tasks[event.id].id, "", "", tasks[event.id].subject, tasks[event.id].content, tasks[event.id].rating, tasks[event.id].owner, tasks[event.id].type, tasks[event.id].date)));
        }
*/
          },
        ),
      ))
          .toList(),
    );
  }
}