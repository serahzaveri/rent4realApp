
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Screens/payMyRent.dart';
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
      padding: const EdgeInsets.all(5.0),
      child: //AppConstants.currentUser.getUpcomingTrips().length==0 ?
       Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              'Process to Book a home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 0.0),
            child: new ListTile(
              leading: Icon(Icons.fiber_manual_record),
              title: new Text(
                  'Find a listing that meets your criteria',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: new ListTile(
              leading: Icon(Icons.fiber_manual_record),
              title: new Text(
                'Complete and Submit MyRentResume',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: new ListTile(
              leading: Icon(Icons.fiber_manual_record),
              title: new Text(
                'Optional: Message landlord for a virtual/physical tour and any other queries regarding listing',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: new ListTile(
              leading: Icon(Icons.fiber_manual_record),
              title: new Text(
                'Sign lease sent by email from Rent4Real',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: new ListTile(
              leading: Icon(Icons.fiber_manual_record),
              title: new Text(
                'Pay 1st month rent and get ready to move in on move in date',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayMyRent(),
                    )
                );
              },
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
              minWidth: MediaQuery.of(context).size.width / 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 10 , 5),
            child: Row(
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PayMyRent(),
                        )
                    );
                  },
                  child: Text(
                    'Maintenance Request',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.lightBlue,
                  //We get the height of the screen so the buttons adjust to size of phone
                  height: MediaQuery.of(context).size.height / 15,
                  minWidth: MediaQuery.of(context).size.width / 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Spacer(),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PayMyRent(),
                        )
                    );
                  },
                  child: Text(
                    'Rental Insurance',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.lightBlue,
                  //We get the height of the screen so the buttons adjust to size of phone
                  height: MediaQuery.of(context).size.height / 15,
                  minWidth: MediaQuery.of(context).size.width / 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ],
            ),
          ),
        ],
      ) /* SingleChildScrollView(
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
            /*
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
            ),*/
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10 , 5),
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'Rental Insurance',
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10 , 25),
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
            /*
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
            ),*/
          ],
        ),
      ),*/
    );
  }
}