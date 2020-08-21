import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/reviewObjects.dart';
import 'package:househunter/Models/userObjects.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:househunter/Views/formWidgets.dart';
import 'package:househunter/Views/listWidgets.dart';

class ViewProfilePage extends StatefulWidget {

  static final String routeName = '/viewProfilePageRoute';

  final Contact contact;

  ViewProfilePage({this.contact, Key key}) : super(key: key);

  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {

  User _user;

  @override
  void initState() {
    if(widget.contact.id == AppConstants.currentUser.id) {
      this._user = AppConstants.currentUser;
    } else {
      //if we are viewing someone else's profile
      this._user = widget.contact.createUserFromContact();
      this._user.getUserInfoFromFirestore().whenComplete(() {
        this._user.getImageFromStorage().whenComplete(() {
          setState(() {});
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppBarText(text: 'View Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 25, 35, 25),
          child: Column(
            //mainAxisAlignment centers the children vertically
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //We wrap auto size text in a container to ensure that the text does not go over the width of the screen
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 5,
                    child: AutoSizeText(
                      'Hi, my name is ${_user.getFullName()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width / 9.5,
                    child: CircleAvatar(
                      backgroundImage: _user.displayImage,
                      radius: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ],
              ),
              MaterialButton(
                color: Colors.blueAccent,
                onPressed: () {},
                child: Text(
                  'View MyRentResume',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Text(
                  'About Me:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: AutoSizeText(
                  'I am a student at ${_user.school} studying ${_user.program}. I am currently in my ${_user.yearOfSchool}.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Date of Birth',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: AutoSizeText(
                          '${_user.dateOfBirth}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Location',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.home),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: AutoSizeText(
                            'Lives in ${_user.city}, ${_user.country}',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.airplanemode_active),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: AutoSizeText(
                              'From ${_user.homeCountry}',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              /*
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Reviews:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ReviewForm(user: this._user,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: StreamBuilder(
                  stream: Firestore.instance.collection('users/${_user.id}/reviews').orderBy('dateTime', descending: true).snapshots(),
                  builder: (context, snapshots) {
                    switch(snapshots.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return ListView.builder(
                          itemCount: snapshots.data.documents.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DocumentSnapshot snapshot = snapshots.data.documents[index];
                            Review currentReview = Review();
                            currentReview.getReviewInfoFromFirestore(snapshot);
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: ReviewListTile(review: currentReview,),
                            );
                          },
                        );
                    }
                  },
                )
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
