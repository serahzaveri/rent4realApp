import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoPage extends StatefulWidget {

  static final String routeName = '/personalInfoPageRoute';

  PersonalInfoPage({Key key}) : super(key: key);

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _cityController;
  TextEditingController _countryController;

  File _newImageFile;

  void _chooseImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      _newImageFile = imageFile;
      setState(() {});
    }
  }


  void _saveInfo() {
    if(!_formKey.currentState.validate()) {return ;}
    AppConstants.currentUser.firstName = _firstNameController.text;
    AppConstants.currentUser.lastName = _lastNameController.text;
    AppConstants.currentUser.city = _cityController.text;
    AppConstants.currentUser.country = _countryController.text;
    AppConstants.currentUser.updateUserInFirestore().whenComplete(() {
      if(_newImageFile != null) {
        AppConstants.currentUser.addImageToFirestore(_newImageFile).whenComplete(() {
          Navigator.pushNamed(context, GuestHomePage.routeName);
        });
      } else {
        Navigator.pushNamed(context, GuestHomePage.routeName);
      }
    });
  }

  @override
  void initState() {
    _firstNameController = TextEditingController(text: AppConstants.currentUser.firstName);
    _lastNameController = TextEditingController(text: AppConstants.currentUser.lastName);
    _emailController = TextEditingController(text: AppConstants.currentUser.email);
    _cityController = TextEditingController(text: AppConstants.currentUser.city);
    _countryController = TextEditingController(text: AppConstants.currentUser.country);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.deepOrangeAccent, size: 25.0),
            onPressed: () {
              Navigator.pop(context);
            }
            ),
        title: Text(
          'Personal Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it in the middle of the parent.
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Column(
              //mainAxisAlignment centers the children vertically
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'First name'
                            ),
                            style: TextStyle(
                              fontSize: 18.0,
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
                              fontSize: 18.0,
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
                              fontSize: 18.0,
                            ),
                            // email ID cant be changed so enabled is false
                            enabled: false,
                            controller: _emailController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            'Email ID cant be changed',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'City'
                            ),
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            controller: _cityController,
                            // city cant be changed rn since it is only available in Montreal so enabled is false
                            enabled: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            'Not editable since currently available in Montreal only',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Country'
                            ),
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            controller: _countryController,
                            // country cant be changed rn since it is only available in Canada so enabled is false
                            enabled: false,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            'Not editable since currently available in Canada only',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: MaterialButton(
                    onPressed: _chooseImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: MediaQuery.of(context).size.width / 4.8,
                      child: CircleAvatar(
                        backgroundImage: (_newImageFile != null)
                            ? FileImage(_newImageFile)
                            : AppConstants.currentUser.displayImage,
                        radius: MediaQuery.of(context).size.width / 5,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 35),
                  child: MaterialButton(
                    onPressed: _saveInfo,
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.deepOrangeAccent,
                    height: MediaQuery.of(context).size.height / 18,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
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