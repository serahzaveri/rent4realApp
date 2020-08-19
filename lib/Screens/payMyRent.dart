import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Views/TextWidgets.dart';

class PayMyRent extends StatefulWidget {

  static final String routeName = '/payMyRentRoute';

  PayMyRent({Key key}) : super(key: key);

  @override
  _PayMyRentState createState() => _PayMyRentState();
}

class _PayMyRentState extends State<PayMyRent> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Page under construction'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 75.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.priority_high, size: 100, color: Colors.yellowAccent,),
            Text(
              'Page under construction',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
          ),
      ),
    );
  }
}
