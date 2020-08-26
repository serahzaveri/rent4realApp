import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/sharedPreferencesHelper.dart';
import 'package:househunter/Models/userObjects.dart';
import 'guestHomePage.dart';


// this page is used to display user's account if user is logged in - shared preferences
class AuthenticatePage extends StatefulWidget {

  static final String routeName = '/authenticPageRoute';

  AuthenticatePage({Key key}) : super(key: key);

  @override
  _AuthenticatePageState createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {

  String isUserID;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async{
    await SharedPreferencesHelper.getUserId().then((value) {
      setState(() {
        //print(value);
        isUserID = value;
      });
    });
    AppConstants.currentUser = User(id: isUserID);
    AppConstants.currentUser.getPersonalInfoFromFirestore().whenComplete(() {
      //print('shared preference working');
      //print(AppConstants.currentUser.id);
      Navigator.pushNamed(context, GuestHomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold();
  }

}