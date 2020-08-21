import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/userObjects.dart';
import 'package:househunter/Views/TextWidgets.dart';

class ViewRentResume extends StatelessWidget {

  static final String routeName = '/viewRentResumeRoute';
  final User user;

  ViewRentResume({this.user, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 35.0),
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: MaterialButton(
                      padding: EdgeInsets.all(0.0),
                      color: Colors.pinkAccent,
                      child: Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
            child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                    child: Container(
                      child: Text(
                        'Rent Resume',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text('Name:  ',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                        ),
                        Container(
                          child: Text(
                            this.user.getFullName(),
                            style: TextStyle(
                                fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Gender: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.gender,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Email ID: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.email,
                          style: TextStyle(
                              fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Date of Birth: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.dateOfBirth,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Contact number: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.contactNumber,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.black,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Emergency Contact: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.emergencyContactName,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Relationship to Emergency Contact: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.emergencyContactRelationship,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Emergency Contact number: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.emergencyContactNumber,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.black,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Present Address',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.presentAddress,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Present Rent: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.presentRent,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Present Landlord Name: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.presentLandlordName,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Present Landlord Number: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.presentLandlordNumber,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Prior Home Address: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.priorAddress,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Prior rent: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.priorRent,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Prior Landlord Name: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.priorLandlordName,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Prior Landlord Number: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          this.user.priorLandlordNumber,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}

