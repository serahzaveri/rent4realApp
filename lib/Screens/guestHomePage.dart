import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/sharedPreferencesHelper.dart';
import 'package:househunter/Models/userObjects.dart';
import 'package:househunter/Screens/accountPage.dart';
import 'package:househunter/Screens/explorePage.dart';
import 'package:househunter/Screens/inboxPage.dart';
import 'package:househunter/Screens/myHomePage.dart';
import 'package:househunter/Screens/savedPage.dart';
import 'package:househunter/Screens/statusPage.dart';
import 'package:househunter/Views/TextWidgets.dart';


class GuestHomePage extends StatefulWidget {

  static final String routeName = '/guestHomePageRoute';

  GuestHomePage({Key key}) : super(key: key);

  @override
  _GuestHomePageState createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  //Setting it to 5 results it to going directly to the profile page after logging in
  //Change to 0 later if you want explore page
  int _selectedIndex = 5;

  final List<String> _pageTitles = [
    'Explore',
    'Saved',
    'Status',
    'MyHome',
    'Inbox',
    'Profile',
  ];

  final List<Widget> _pages = [
    ExplorePage(),
    SavedPage(),
    StatusPage(),
    MyHomePage(),
    InboxPage(),
    AccountPage(),
  ];

  BottomNavigationBarItem _buildNavigationItem(int index, IconData iconData, String text) {
    return BottomNavigationBarItem(
      icon: Icon(iconData, color: AppConstants.nonSelectedIconColor),
      activeIcon: Icon(iconData, color: AppConstants.selectedIconColor),
      title: Text(
        text,
        style: TextStyle(
          color: _selectedIndex == index ? AppConstants.selectedIconColor : AppConstants.nonSelectedIconColor
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

        },
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem> [
          _buildNavigationItem(0, Icons.search, _pageTitles[0]),
          _buildNavigationItem(1, Icons.favorite_border, _pageTitles[1]),
          _buildNavigationItem(2, Icons.timelapse, _pageTitles[2]),
          _buildNavigationItem(3, Icons.home, _pageTitles[3]),
          _buildNavigationItem(4, Icons.message, _pageTitles[4]),
          _buildNavigationItem(5, Icons.person_outline, _pageTitles[5]),
        ],
      ),
    );
  }
}
