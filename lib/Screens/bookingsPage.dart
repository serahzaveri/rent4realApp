import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Views/calendarWidgets.dart';
import 'package:househunter/Views/listWidgets.dart';

// this page is used for the host end of bookings

class BookingsPage extends StatefulWidget {

  BookingsPage({Key key}) : super(key: key);

  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 35.0),
              child: Row(
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
            ),
            Container(
                height: MediaQuery.of(context).size.height / 1.9,
                child: PageView.builder(
                  //no of months it will display
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return CalendarMonthWidget(monthIndex: index,);
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 25.0, 0.0, 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Filter by Posting',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: InkResponse(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                          ),
                        borderRadius: BorderRadius.circular(5.0),
                        ),
                      child: MyPostingListTile(),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}