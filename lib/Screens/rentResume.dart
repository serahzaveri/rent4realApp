import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Views/TextWidgets.dart';

class RentResumePage extends StatefulWidget {

  static final String routeName = '/rentResumePageRoute';

  RentResumePage({Key key}) : super(key: key);

  @override
  _RentResumePagePageState createState() => _RentResumePagePageState();
}

class _RentResumePagePageState extends State<RentResumePage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _cityController;
  TextEditingController _countryController;
  TextEditingController _bioController;


  void _saveInfo() {
    if(!_formKey.currentState.validate()) {return ;}
    AppConstants.currentUser.firstName = _firstNameController.text;
    AppConstants.currentUser.lastName = _lastNameController.text;
    AppConstants.currentUser.city = _cityController.text;
    AppConstants.currentUser.country = _countryController.text;
    AppConstants.currentUser.bio = _bioController.text;
    AppConstants.currentUser.updateUserInFirestore().whenComplete(() {
      Navigator.pushNamed(context, GuestHomePage.routeName);
    });
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
                    key: _formKey,
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
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid first name";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
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
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid last name";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
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
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid city";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
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
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid country";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
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
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid bio";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}