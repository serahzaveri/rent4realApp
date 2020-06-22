
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Creating this class to prevent reusing code and having custom app bar names to go back for most screens

class AppBarText extends StatelessWidget {
  final String text;
  AppBarText({Key key, this.text}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 25.0,
      ),
    );
  }

}