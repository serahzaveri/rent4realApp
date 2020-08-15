import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Screens/createPostingPage.dart';
import 'package:househunter/Views/listWidgets.dart';

// this page is used for displaying the lease

class MyLeasePage extends StatefulWidget {

  MyLeasePage({Key key}) : super(key: key);

  @override
  _MyLeasePageState createState() => _MyLeasePageState();
}

class _MyLeasePageState extends State<MyLeasePage> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Column(
        children: <Widget>[
          Text('my lease page'),
        ],
      )
    );
  }
}