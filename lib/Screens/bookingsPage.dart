import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// this page is used for the host end of bookings

class BookingsPage extends StatefulWidget {

  BookingsPage({Key key}) : super(key: key);

  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Bookings Page'),
    );
  }
}