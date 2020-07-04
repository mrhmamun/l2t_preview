import 'dart:convert';
import 'dart:io';

import 'package:link2task/API.dart';
import 'package:flutter/material.dart';
import 'package:link2task/Login.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email_c = new TextEditingController();
  TextEditingController password_c = new TextEditingController();
  TextEditingController password_confirm_c = new TextEditingController();
  TextEditingController username_c = new TextEditingController();
  TextEditingController phone_number_c = new TextEditingController();
  Country _selected;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Color(0xFF05A0DA),
      body:

      SingleChildScrollView(
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
                      padding: const EdgeInsets.only(bottom: 10.0),
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
                              controller: email_c,
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                color: const Color(0xff3a3a3a),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 14.0, left: 0.0, bottom: 10.0),
                                hintText: 'Email',
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
                          Container(
                            padding: EdgeInsets.only(
                                left: 20.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 20.0),
                            alignment: Alignment.centerLeft,
                            height: 60.0,
                            child: TextField(
                              controller: password_confirm_c,
                              obscureText: true,
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                color: const Color(0xff3a3a3a),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 14.0, left: 0.0, bottom: 10.0),
                                hintText: 'Password (again)',
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
                              controller: username_c,
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                color: const Color(0xff3a3a3a),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 14.0, left: 0.0, bottom: 10.0),
                                hintText: 'Username',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),

                          Row(
                            children: <Widget>[
                              Expanded(
                                child: CountryPicker(
                                  dialingCodeTextStyle:
                                  GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: const Color(0xff3a3a3a),
                                  ),
                                  showDialingCode: true,
                                  showFlag: true,
                                  showName: false,
                                  showCurrencyISO: false,
                                  onChanged: (Country country) {
                                    setState(() {
                                      _selected = country;
                                    });
                                  },
                                  selectedCountry: _selected,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: phone_number_c,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: const Color(0xff3a3a3a),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Phone Number",

                                  ),
                                  onChanged: (value) {
                                    // this.phoneNo=value;
                                    print(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        if(password_c.text == password_confirm_c.text) {
                          String Token;
                          _firebaseMessaging.getToken().then((token) {
                            Token=(token); // Print the Token in Console

                            API.signUp(
                                email_c.text, password_c.text, username_c.text,
                                "1"+""+phone_number_c.text, "",Token).then((response) {
                              setState(() {
                                if(jsonDecode(response.body)["status"]){
                                  //Signup successfull
                                  //showSuccessFlushbar(context, "Signup successful.", jsonDecode(response.body)["message"]);
                                  Navigator.pop(context,'Username is registered.');

                                }else{
                                  //Signup failed
                                  showErrorFlushbar(context, "Signup failed.", jsonDecode(response.body)["message"]);
                                }
                              });
                            });
                          });
                        }else{
                          showErrorFlushbar(context, "Signup failed", "Passwords doesn't match.");
                        }
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
                                  text: 'Sign up',
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
                    ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
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
                                  text: 'Log in',
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
    duration: Duration(seconds: 2),
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
    duration: Duration(seconds: 2),
  )..show(context);
}
