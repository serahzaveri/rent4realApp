
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Screens/viewPostingsPage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:househunter/Views/gridWidgets.dart';

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                'My home',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.3,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: AppConstants.currentUser.getUpcomingTrips().length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Booking currentBooking = AppConstants.currentUser.getUpcomingTrips()[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                          child: InkResponse(
                              enableFeedback: true,
                              child: HomeGridTile(booking: currentBooking,),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewPostingsPage(posting: currentBooking.posting,),
                                    )
                                );
                              }
                          ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Text(
              'Previous home\'s',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.3,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: AppConstants.currentUser.getPreviousTrips().length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Booking currentBooking = AppConstants.currentUser.getPreviousTrips()[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: InkResponse(
                              enableFeedback: true,
                              child: HomeGridTile(booking: currentBooking,),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewPostingsPage(posting: currentBooking.posting,),
                                    )
                                );
                              }
                          ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}