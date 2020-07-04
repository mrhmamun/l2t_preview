import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Link2Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(
          title: 'TASK FRIENDS, FAMILY AND EXPERTS. GET IT DONE!'),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;
  AnimationController _controller3;
  Animation<Offset> _animation;
  Animation<Offset> _animation2;
  Animation<Offset> _animation3;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1800));
    _animation = Tween<Offset>(begin: Offset(-1.5, 0), end: (Offset(0, 0)))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    ));
    _controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _animation2 = Tween<Offset>(begin: Offset(1.5, 0), end: (Offset(0, 0)))
        .animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInOutBack,
    ));
    _controller3 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2200));
    _animation3 = Tween<Offset>(begin: Offset(0, 2), end: (Offset(0, 0)))
        .animate(CurvedAnimation(
      parent: _controller3,
      curve: Curves.easeInOutBack,
    ));
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    _controller2.forward();
    _controller3.forward();

    return Scaffold(
      backgroundColor: Color(0xFF05A0DA),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF05A0DA), Color(0xFF016185)])),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: SlideTransition(
                      position: _animation2,
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                            fontSize: 38,
                            color: Color(0xffffffff),
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 20),
                                blurRadius: 50,
                                color:
                                    const Color(0xff000000).withOpacity(0.16),
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
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    '\n\nTASK FRIENDS,\nFAMILY AND EXPERTS.\n\nGET IT DONE!',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(0, 20),
                                        blurRadius: 50,
                                        color: const Color(0xff000000)
                                            .withOpacity(0.16),
                                      )
                                    ])),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 80.0),
                      child: SlideTransition(
                        position: _animation3,
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 38,
                              color: Color(0xffffffff),
                              shadows: [
                                Shadow(
                                  offset: const Offset(0, 20),
                                  blurRadius: 50,
                                  color:
                                      const Color(0xff000000).withOpacity(0.16),
                                ),
                              ],
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\nTap to continue!',
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(0, 20),
                                          blurRadius: 50,
                                          color: const Color(0xff000000)
                                              .withOpacity(0.16),
                                        )
                                      ])),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: -70,
                    child: SlideTransition(
                      position: _animation,
                      child: Container(
                        width: 145,
                        height: 145,
                        decoration: BoxDecoration(
                          color: const Color(0xffffbe04),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 20),
                              blurRadius: 50,
                              color: const Color(0xff000000).withOpacity(0.16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -40,
                    right: 90,
                    child: Transform.rotate(
                      angle: 90,
                      child: SlideTransition(
                        position: _animation,
                        child: Container(
                          width: 109,
                          height: 107,
                          decoration: BoxDecoration(
                            color: const Color(0xff70d8ff),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 20),
                                blurRadius: 50,
                                color:
                                    const Color(0xff000000).withOpacity(0.16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -70,
                    top: 170,
                    child: Transform.rotate(
                      angle: 180,
                      child: SlideTransition(
                        position: _animation,
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                            color: const Color(0xffffbe04),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 20),
                                blurRadius: 50,
                                color:
                                    const Color(0xff000000).withOpacity(0.16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 190,
                    left: -40,
                    child: Transform.rotate(
                      angle: 270,
                      child: SlideTransition(
                        position: _animation,
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: const Color(0xff70d8ff),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 20),
                                blurRadius: 50,
                                color:
                                    const Color(0xff000000).withOpacity(0.16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -70,
                    bottom: 180,
                    child: Transform.rotate(
                      angle: 90,
                      child: SlideTransition(
                        position: _animation,
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                            color: const Color(0xffffbe04),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 20),
                                blurRadius: 50,
                                color:
                                    const Color(0xff000000).withOpacity(0.16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -60,
                    right: 0,
                    child: Transform.rotate(
                      angle: 180,
                      child: SlideTransition(
                        position: _animation,
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: const Color(0xff70d8ff),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 20),
                                blurRadius: 50,
                                color:
                                    const Color(0xff000000).withOpacity(0.16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -20,
                    bottom: -60,
                    child: Transform.rotate(
                      angle: 3.14 / -1.7,
                      child: SlideTransition(
                        position: _animation,
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                            color: const Color(0xffffbe04),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 20),
                                blurRadius: 50,
                                color:
                                    const Color(0xff000000).withOpacity(0.16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                overflow: Overflow.visible,
              )),
        ),
      ),
    );
  }
}
