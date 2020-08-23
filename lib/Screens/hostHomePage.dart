import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Screens/accountPage.dart';
import 'package:househunter/Screens/bookingsPage.dart';
import 'package:househunter/Screens/inboxPage.dart';
import 'package:househunter/Screens/myLeasePage.dart';
import 'package:househunter/Screens/myPostingsPage.dart';
import 'package:househunter/Views/TextWidgets.dart';


class HostHomePage extends StatefulWidget {

  static final String routeName = '/hostHomePageRoute';
  final int index; //we have this variable to know which page to navigate to

  HostHomePage({Key key, this.index}) : super(key: key);

  @override
  _HostHomePageState createState() => _HostHomePageState();
}

class _HostHomePageState extends State<HostHomePage> {
  //Setting it to 4 results it to going directly to the profile page after logging in
  int _selectedIndex = 4;

  final List<String> _pageTitles = [
    'Bookings',
    'MyPostings',
    'Lease',
    'Inbox',
    'Profile',
  ];

  final List<Widget> _pages = [
    BookingsPage(),
    MyPostingsPage(),
    MyLeasePage(),
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
  void initState() {
    //we do this so after creating a post it navigates to the myPostings tab and not profile tab
    this._selectedIndex = widget.index ?? 4;
    super.initState();
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
          _buildNavigationItem(0, Icons.calendar_today, _pageTitles[0]),
          _buildNavigationItem(1, Icons.home, _pageTitles[1]),
          _buildNavigationItem(2, Icons.picture_as_pdf, _pageTitles[2]),
          _buildNavigationItem(3, Icons.message, _pageTitles[3]),
          _buildNavigationItem(4, Icons.person_outline, _pageTitles[4]),
        ],
      ),
    );
  }
}
