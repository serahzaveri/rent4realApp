
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 35, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                'Current home',
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10 , 5),
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'Pay My Rent',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                color: Colors.redAccent,
                //We get the height of the screen so the buttons adjust to size of phone
                height: MediaQuery.of(context).size.height / 15,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10 , 25),
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'Maintenance Request',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                color: Colors.lightBlue,
                //We get the height of the screen so the buttons adjust to size of phone
                height: MediaQuery.of(context).size.height / 15,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
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