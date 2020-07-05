import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Views/TextWidgets.dart';

class PersonalInfoPage extends StatefulWidget {

  static final String routeName = '/personalInfoPageRoute';

  PersonalInfoPage({Key key}) : super(key: key);

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _cityController;
  TextEditingController _countryController;
  TextEditingController _bioController;

  void _saveInfo() {
    Navigator.pushNamed(context, GuestHomePage.routeName);
  }

  @override
  void initState() {
    _firstNameController = TextEditingController(text: AppConstants.currentUser.firstName);
    _lastNameController = TextEditingController(text: AppConstants.currentUser.lastName);
    _emailController = TextEditingController(text: AppConstants.currentUser.email);
    _cityController = TextEditingController(text: AppConstants.currentUser.city);
    _countryController = TextEditingController(text: AppConstants.currentUser.country);
    _bioController = TextEditingController(text: AppConstants.currentUser.bio);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppBarText(text: 'Personal Information'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save, color: Colors.white), onPressed: _saveInfo)
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it in the middle of the parent.
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Column(
              //mainAxisAlignment centers the children vertically
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Form(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'First name'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _firstNameController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Last name'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _lastNameController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email ID'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            enabled: false,
                            controller: _emailController,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'City'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _cityController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Country'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _countryController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Bio'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _bioController,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    )
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: MaterialButton(
                    onPressed: () {},
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: MediaQuery.of(context).size.width / 4.8,
                      child: CircleAvatar(
                        backgroundImage: AppConstants.currentUser.displayImage,
                        radius: MediaQuery.of(context).size.width / 5,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}