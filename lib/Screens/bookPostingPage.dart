import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:househunter/Views/calendarWidgets.dart';

class BookPostingPage extends StatefulWidget {

  final Posting posting;
  static final String routeName = '/bookPostingPageRoute';

  BookPostingPage({this.posting, Key key}) : super(key: key);

  @override
  _BookPostingPageState createState() => _BookPostingPageState();
}

class _BookPostingPageState extends State<BookPostingPage> {

  Posting _posting;

  @override
  void initState() {
    this._posting = widget.posting;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppBarText(text: 'Book a Posting')
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Sun'),
                Text('Mon'),
                Text('Tue'),
                Text('Wed'),
                Text('Thu'),
                Text('Fri'),
                Text('Sat')
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.8,
              child: PageView.builder(
                //no of months it will display
                itemCount: 12,
                itemBuilder: (context, index) {
                  return CalendarMonthWidget(monthIndex: index, bookedDates: _posting.getAllBookedDates(),);
                },
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Text('Book now!'),
              minWidth: double.infinity,
              height: MediaQuery.of(context).size.height / 14,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
