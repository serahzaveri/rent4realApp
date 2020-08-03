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
  List<CalendarMonthWidget> _calendarWidgets = [];
  List<DateTime> _bookedDates = [];
  List<DateTime> _selectedDates = [];

  void _buildCalendarWidgets() {
    _calendarWidgets = [];
    for(int i =0; i<12; i++) {
      _calendarWidgets.add(CalendarMonthWidget(monthIndex: i, bookedDates: _bookedDates, selectDate: _selectDate, getSelectedDates: _getSelectedDates,));
    }
    setState(() {});
  }

  List<DateTime> _getSelectedDates() {
    return this._selectedDates;
  }

  void _selectDate(DateTime date) {
    if(this._selectedDates.contains(date)) {
      this._selectedDates.remove(date);
    } else {
      this._selectedDates.add(date);
    }
    this._selectedDates.sort();
    setState(() {

    });
    print(this._selectedDates);
  }

  void _loadBookedDates() {
    _bookedDates = [];
    this._posting.getAllBookingsFromFirestore().whenComplete(() {
      this._bookedDates = this._posting.getAllBookedDates();
      this._buildCalendarWidgets();
    });
  }

  void _makeBooking() {
    if(this._selectedDates.isEmpty) { return; }
    this._posting.makeNewBooking(this._selectedDates, context).whenComplete(() {
      //Navigator.pop(context);
    });
  }

  @override
  void initState() {
    this._posting = widget.posting;
    this._loadBookedDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppBarText(text: 'Book ${this._posting.getFullAddress()}')
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
              child: (_calendarWidgets.isEmpty) ? Container() : PageView.builder(
                //no of months it will display
                itemCount: _calendarWidgets.length,
                itemBuilder: (context, index) {
                  return _calendarWidgets[index];
                },
              ),
            ),
            MaterialButton(
              onPressed: _makeBooking,
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
