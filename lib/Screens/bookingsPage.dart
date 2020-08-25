import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Models/userObjects.dart';
import 'package:househunter/Views/calendarWidgets.dart';
import 'package:househunter/Views/listWidgets.dart';

// this page is used for the host end of bookings

class BookingsPage extends StatefulWidget {

  BookingsPage({Key key}) : super(key: key);

  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {

  Future userFuture;
  List<Posting> postingsWithBookings = [];

  @override
  void initState() {
    super.initState();
    userFuture = _getData();
  }

  _getData() async {
    //gets postings of landlord and updates all posting with bookings
    await AppConstants.currentUser.getMyPostingsFromFirestore().then((value) {
      //gets all posting that have bookings
      //print("BEFORE");
      postingsWithBookings = AppConstants.currentUser.getPostingsWithBookings();
      //print("AFTER");
      //print("Check her:" + postingsWithBookings[0].bookings[0].userID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userFuture,
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return Text('none');
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 25.0),
                      child: this.postingsWithBookings.length !=0 ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: this.postingsWithBookings.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: InkResponse(
                                onTap: () {},
                                child: Container(
                                  child: BookingsListTile(posting: this.postingsWithBookings[index],),
                                ),
                              ),
                            );
                          }
                      ) :
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 25.0),
                        child: Container(
                            child: Text(
                              'No bookings yet',
                              style: TextStyle(
                                  fontSize: 22.0
                              ),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 25.0),
                      child: Container(
                          color: Colors.yellowAccent,
                          child: Text(
                            'Filed Maintenace Requests',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 25.0),
                      child: Container(
                          color: Colors.redAccent,
                          child: Text(
                            'Payment History',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            );
          default:
            return Text('default');
        }
      },
    );
  }
}