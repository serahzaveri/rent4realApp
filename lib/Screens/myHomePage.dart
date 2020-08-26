
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
      child: AppConstants.currentUser.bookings.length == 0 ?
       Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              'Process to Book a home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
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
                  fontSize: 16.0
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
                  fontSize: 16.0,
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
                  fontSize: 16.0,
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
                  fontSize: 16.0,
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
                  fontSize: 16.0,
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
                  fontSize: 14.0,
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
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.lightBlue,
                  //We get the height of the screen so the buttons adjust to size of phone
                  height: MediaQuery.of(context).size.height / 15,
                  minWidth: MediaQuery.of(context).size.width / 3.5,
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
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.lightBlue,
                  //We get the height of the screen so the buttons adjust to size of phone
                  height: MediaQuery.of(context).size.height / 15,
                  minWidth: MediaQuery.of(context).size.width / 3.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ],
            ),
          ),
        ],
      ) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 10.0),
              child: Text(
                'Booked Home',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 20.0),
              child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: double.infinity,
                  child: HomeGridTile(booking: AppConstants.currentUser.bookings[0],),
                ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20 , 5),
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
                      'Pay My Rent',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.redAccent,
                      ),
                    ),
                    color: Colors.amber,
                    //We get the height of the screen so the buttons adjust to size of phone
                    height: MediaQuery.of(context).size.height / 15,
                    minWidth: MediaQuery.of(context).size.width / 3.5,
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
                      'View My Lease',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.redAccent,
                      ),
                    ),
                    color: Colors.amber,
                    //We get the height of the screen so the buttons adjust to size of phone
                    height: MediaQuery.of(context).size.height / 15,
                    minWidth: MediaQuery.of(context).size.width / 3.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10 , 5),
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
                      'Rental Insurance',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.redAccent,
                      ),
                    ),
                    color: Colors.amber,
                    //We get the height of the screen so the buttons adjust to size of phone
                    height: MediaQuery.of(context).size.height / 15,
                    minWidth: MediaQuery.of(context).size.width / 3.5,
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
                      'Renew My Lease',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.redAccent,
                      ),
                    ),
                    color: Colors.amber,
                    //We get the height of the screen so the buttons adjust to size of phone
                    height: MediaQuery.of(context).size.height / 15,
                    minWidth: MediaQuery.of(context).size.width / 3.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10 , 25),
              child: Center(
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
                    'File a Maintenance Request',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.deepOrangeAccent,
                  //We get the height of the screen so the buttons adjust to size of phone
                  height: MediaQuery.of(context).size.height / 15,
                  minWidth: MediaQuery.of(context).size.width / 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}