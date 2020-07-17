import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Screens/bookPostingPage.dart';
import 'package:househunter/Screens/conversationPage.dart';
import 'package:househunter/Screens/createPostingPage.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Screens/hostHomePage.dart';
import 'package:househunter/Screens/loginPage.dart';
import 'package:househunter/Screens/personalInfoPage.dart';
import 'package:househunter/Screens/signUpPage.dart';
import 'package:househunter/Screens/viewPostingsPage.dart';
import 'package:househunter/Screens/viewProfilePage.dart';

void main() => runApp(MyApp());
// this is where the code starts from main method calling MyApp

//A widget is either stateful or stateless.
// If a widget can change when a user interacts with it then it's stateful. A stateless widget never changes.
// When the widget's state changes, the state object calls setState() , telling the framework to redraw the widget.

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent4Real',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        GuestHomePage.routeName: (context) => GuestHomePage(),
        PersonalInfoPage.routeName: (context) => PersonalInfoPage(),
        ViewProfilePage.routeName: (context) => ViewProfilePage(),
        BookPostingPage.routeName: (context) => BookPostingPage(),
        ConversationPage.routeName: (context) => ConversationPage(),
        HostHomePage.routeName: (context) => HostHomePage(),
        CreatePostingPage.routeName: (context) => CreatePostingPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      //we navigate to the LoginPage screen
      Navigator.pushNamed(context, LoginPage.routeName);
    });
    super.initState();
  }
  //Before we get the login page we see the name of the app for 2 seconds. below is where this is done
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it in the middle of the parent.
        child: Column(
          //mainAxisAlignment centers the children vertically
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /*Icon(
              Icons.home,
              size: 80,
            ),*/
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/finalLogo.png')
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                '${AppConstants.appName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                'A better way to Rent',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
