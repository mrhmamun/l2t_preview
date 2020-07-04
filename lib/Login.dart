import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link2task/Dashboard.dart';
import 'package:link2task/Signup.dart';
import 'package:link2task/API.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flushbar/flushbar.dart';
import 'dart:convert';
import 'package:link2task/models/Globals.dart' as globals;


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username_c = new TextEditingController();
  TextEditingController password_c = new TextEditingController();



  void main() {

    runApp(MaterialApp(
      title: 'L2T',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => Dashboard(),
      },
    ));
  }


  @override
  void initState() {
    super.initState();
    main();
  }

  _navigateAndDisplaySelection(BuildContext context) async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );

/*
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
*/
    showSuccessFlushbar(context, "Success", "$result");
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(

      backgroundColor: Color(0xFF05A0DA),
      body: SingleChildScrollView(


      child:SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 350,
                      height: 265,
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
                          Container(
                            padding: EdgeInsets.only(
                                left: 20.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 20.0),
                            alignment: Alignment.centerLeft,
                            height: 60.0,
                            child: TextField(
                              controller: username_c,
                              keyboardType: TextInputType.text,
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                color: const Color(0xff3a3a3a),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 14.0, left: 0.0, bottom: 10.0),
                                hintText: 'Username / Phone number',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 20.0),
                            alignment: Alignment.centerLeft,
                            height: 60.0,
                            child: TextField(
                              controller: password_c,
                              obscureText: true,
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                color: const Color(0xff3a3a3a),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 14.0, left: 0.0, bottom: 10.0),
                                hintText: 'Password',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(right: 20.0),
                                child: RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
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
                                          text: 'Forgot password?',
                                          style: TextStyle(
                                              color: Color(0xff039cd6),
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child: RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
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
                                          text: 'Social Login',
                                          style: TextStyle(
                                              color: Color(0xff3a3a3a),
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 20),
                                      blurRadius: 50,
                                      color: const Color(0xff000000).withOpacity(0.16),
                                    )
                                  ],
                                ),
                                height: 50.0,
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Image.asset('assets/facebook.png'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 20),
                                      blurRadius: 50,
                                      color: const Color(0xff000000).withOpacity(0.16),
                                    )
                                  ],
                                ),
                                height: 50.0,
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Image.asset('assets/twitter.png'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 20),
                                      blurRadius: 50,
                                      color: const Color(0xff000000).withOpacity(0.16),
                                    )
                                  ],
                                ),
                                height: 50.0,
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Image.asset('assets/google.png'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 20),
                                      blurRadius: 50,
                                      color: const Color(0xff000000).withOpacity(0.16),
                                    )
                                  ],
                                ),
                                height: 50.0,
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Image.asset('assets/linkedin.png'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        API.logIn(username_c.text, password_c.text).then((response) {
                          if(json.decode(response.body)["status"] == true){
                            globals.LoggedIn_g = json.decode(response.body)["status"];
                            globals.UserId_g = json.decode(response.body)["id"];
                            globals.UserName_g=json.decode(response.body)["username"];


                            Navigator.pushReplacementNamed(context, "/dashboard");

                          }
                          else{
                            showErrorFlushbar(context,"Login failed" ,json.decode(response.body)["message"]);
                          }
                        });
                      },
                    child: Container(
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
                                  text: 'Log in',
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
                                      ])),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                    ),
                    GestureDetector(
                      onTap: () {
                        _navigateAndDisplaySelection(context);
                      },
                      child: Container(
                        width: 170,
                        height: 48,
                        margin: const EdgeInsets.only(top: 10.0),
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 38,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign up',
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
                  ],
                ),
              ),
            ],
            overflow: Overflow.visible,
          ),
        ),
      ),
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
    duration: Duration(seconds: 4),
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
    duration: Duration(seconds: 7),
  )..show(context);
}