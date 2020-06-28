import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Screens/accountPage.dart';
import 'package:househunter/Screens/bookingsPage.dart';
import 'package:househunter/Screens/inboxPage.dart';
import 'package:househunter/Screens/myPostingsPage.dart';
import 'package:househunter/Views/TextWidgets.dart';


class HostHomePage extends StatefulWidget {

  static final String routeName = '/hostHomePageRoute';

  HostHomePage({Key key}) : super(key: key);

  @override
  _HostHomePageState createState() => _HostHomePageState();
}

class _HostHomePageState extends State<HostHomePage> {
  //Setting it to 4 results it to going directly to the profile page after logging in
  //Change to 0 later if you want explore page
  int _selectedIndex = 3;

  final List<String> _pageTitles = [
    'Bookings',
    'MyPostings',
    'Inbox',
    'Profile',
  ];

  final List<Widget> _pages = [
    BookingsPage(),
    MyPostingsPage(),
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
      appBar: AppBar(
        title: AppBarText(text: _pageTitles[_selectedIndex]),
        //this gets rid of the back button on the app bar
        automaticallyImplyLeading: false,
      ),
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
          _buildNavigationItem(0, Icons.calendar_today, _pageTitles[0]),
          _buildNavigationItem(1, Icons.home, _pageTitles[1]),
          _buildNavigationItem(2, Icons.message, _pageTitles[2]),
          _buildNavigationItem(3, Icons.person_outline, _pageTitles[3]),
        ],
      ),
    );
  }
}
