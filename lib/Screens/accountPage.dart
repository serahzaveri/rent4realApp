import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/sharedPreferencesHelper.dart';
import 'package:househunter/Screens/hostHomePage.dart';
import 'package:househunter/Screens/loginPage.dart';
import 'package:househunter/Screens/personalInfoPage.dart';
import 'package:househunter/Screens/rentResume.dart';
import 'package:househunter/Screens/viewProfilePage.dart';
import 'guestHomePage.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AccountPage extends StatefulWidget {

  AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  bool _isRentResumeVisible = true; //used to decide whether rent resume should be visible or not
  String _hostingTitle;

  void _logout() {
    SharedPreferencesHelper.saveUserLoggedInSharedPreference(false);
    Navigator.pushNamed(context, LoginPage.routeName);
  }

  void _myRentResume() {
    Navigator.pushNamed(context, RentResumePage.routeName);
  }

  void _changeHosting() {
    if(AppConstants.currentUser.isHost) {
      if(AppConstants.currentUser.isCurrentlyHosting) {
        AppConstants.currentUser.isCurrentlyHosting = false;
        Navigator.pushNamed(
          context,
          GuestHomePage.routeName,
        );
      } else {
        AppConstants.currentUser.isCurrentlyHosting = true;
        Navigator.pushNamed(
          context,
          HostHomePage.routeName,
        );
      }
    } else {
      AppConstants.currentUser.becomeHost().whenComplete(() {
        AppConstants.currentUser.isCurrentlyHosting = true;
        Navigator.pushNamed(
          context,
          HostHomePage.routeName,
        );
      });
    }
  }

  @override
  void initState() {
    if(AppConstants.currentUser.isHost) {
      if(AppConstants.currentUser.isCurrentlyHosting) {
        _hostingTitle = 'To Guest Dashboard';
        _isRentResumeVisible = false;
      } else {
        _hostingTitle = 'To Host Dashboard';
        _isRentResumeVisible = true;
      }
    } else {
      _hostingTitle = 'Become a host';
      _isRentResumeVisible = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewProfilePage(contact: AppConstants.currentUser.createContactFromUser(),),
                        )
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width / 9.5,
                    child: CircleAvatar(
                      backgroundImage: AppConstants.currentUser.displayImage,
                      radius: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        AppConstants.currentUser.getFullName(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      AutoSizeText(
                        AppConstants.currentUser.email,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              MaterialButton(
                height: MediaQuery.of(context).size.height / 9.0,
                onPressed: () {
                  Navigator.pushNamed(context, PersonalInfoPage.routeName);
                },
                child: AccountPageListTile(text: 'Personal Information', iconData: Icons.person,)
              ),
              Visibility(
                visible: _isRentResumeVisible,
                child: MaterialButton(
                    height: MediaQuery.of(context).size.height / 9.0,
                    onPressed: _myRentResume,
                    child: AccountPageListTile(text: 'My Rent Resume (' + AppConstants.currentUser.progressBar.toString() + "% complete)", iconData: Icons.picture_as_pdf,)
                ),
              ),
              MaterialButton(
                  height: MediaQuery.of(context).size.height / 9.0,
                  onPressed: _changeHosting,
                  child: AccountPageListTile(text: _hostingTitle, iconData: Icons.home,)
              ),
              MaterialButton(
                  height: MediaQuery.of(context).size.height / 9.0,
                  onPressed: () {},
                  child: AccountPageListTile(text: 'How this works', iconData: Icons.device_unknown,)
              ),
              MaterialButton(
                  height: MediaQuery.of(context).size.height / 9.0,
                  onPressed: _logout,
                  child: AccountPageListTile(text: 'Logout', iconData: null,)
              ),
            ],
          ),
        ],
      ),

    );
  }
}

class AccountPageListTile extends StatelessWidget {

  final String text;
  final IconData iconData;

  AccountPageListTile({Key key, this.text, this.iconData}): super(key: key);



  @override
  Widget build(BuildContext context) {
    print(this.text);
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      leading: Text(
        this.text,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: Icon(
        this.iconData,
        size: 30.0,
      ),
    );
  }
}