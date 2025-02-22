import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/sharedPreferencesHelper.dart';
import 'package:househunter/Screens/authenticatePage.dart';
import 'package:househunter/Screens/conversationPage.dart';
import 'package:househunter/Screens/createPostingPage.dart';
import 'package:househunter/Screens/forgotPasswordPage.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Screens/hostHomePage.dart';
import 'package:househunter/Screens/loginPage.dart';
import 'package:househunter/Screens/payMyRent.dart';
import 'package:househunter/Screens/personalInfoPage.dart';
import 'package:househunter/Screens/rentResume.dart';
import 'package:househunter/Screens/signUpPage.dart';
import 'package:househunter/Screens/viewProfilePage.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(MyApp());

}
// this is where the code starts from main method calling MyApp

//A widget is either stateful or stateless.
// If a widget can change when a user interacts with it then it's stateful. A stateless widget never changes.
// When the widget's state changes, the state object calls setState() , telling the framework to redraw the widget.

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isUserLoggedIn;

  @override
  void initState() {
    getLoggedIn();
    super.initState();
  }

  //used for shared preferences
  getLoggedIn() async {
    await SharedPreferencesHelper.getUserLoggedIn().then((value) {
      setState(() {
        isUserLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent4Real',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isUserLoggedIn != null ? isUserLoggedIn ? AuthenticatePage() : MyHomePage()
          : Container(
        child: Center(
          child: MyHomePage(),
        ),
      ),
      routes: {
        AuthenticatePage.routeName: (context) => AuthenticatePage(),
        LoginPage.routeName: (context) => LoginPage(),
        ForgotPasswordPage.routeName: (context) => ForgotPasswordPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        GuestHomePage.routeName: (context) => GuestHomePage(),
        PersonalInfoPage.routeName: (context) => PersonalInfoPage(),
        ViewProfilePage.routeName: (context) => ViewProfilePage(),
        ConversationPage.routeName: (context) => ConversationPage(),
        HostHomePage.routeName: (context) => HostHomePage(),
        CreatePostingPage.routeName: (context) => CreatePostingPage(),
        RentResumePage.routeName: (context) => RentResumePage(),
        PayMyRent.routeName: (context) => PayMyRent(),
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
    Timer(Duration(seconds: 4), () {
      //we navigate to the LoginPage screen
      if(!mounted) return;
      Navigator.pushNamed(context, LoginPage.routeName);
    });
    super.initState();
  }
  //Before we get the login page we see the name of the app for 2 seconds. below code defines this functionality
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it in the middle of the parent.
        child: Column(
          //mainAxisAlignment centers the children vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/logo.jpg')
                  )
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
