import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/userObjects.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:househunter/Screens/loginPage.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {

  static final String routeName = '/signUpPageRoute';

  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  String _error;
  File _imageFile;

  void _chooseImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      _imageFile = imageFile;
      setState(() {});
    }
  }

  //the following function helps navigate to the signUp Page when user clicks Sign Up button
  void _back() {
    //we don't validate this form instead we just go to the signUp page
    Navigator.pushNamed(context, LoginPage.routeName);
  }

  void _submit() async {
    FirebaseUser firebaseUser;
    if(!_formKey.currentState.validate() || this._imageFile == null) { return; }
    String email = _emailController.text;
    String password = _passwordController.text;
    try{
      AppConstants.currentUser = User();
      AppConstants.currentUser.email = email;
      AppConstants.currentUser.password = password;
      firebaseUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
        String userID = firebaseUser.uid;
        AppConstants.currentUser.id = userID;
        AppConstants.currentUser.firstName = _firstNameController.text;
        AppConstants.currentUser.lastName = _lastNameController.text;
        AppConstants.currentUser.city = _cityController.text;
        AppConstants.currentUser.country = _countryController.text;
        AppConstants.currentUser.bio = _bioController.text;
        AppConstants.currentUser.addUserToFirestore().whenComplete(() {
          AppConstants.currentUser.addImageToFirestore(_imageFile).whenComplete(() {
            FirebaseAuth.instance.signInWithEmailAndPassword(
              email: AppConstants.currentUser.email,
              password: AppConstants.currentUser.password,
            ).whenComplete(() {
              Navigator.pushNamed(context, GuestHomePage.routeName);
            });
          });
        });
    } catch(error){
      print('error message detected');
      setState(() {
      _error = error.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        //checking to see if github uploads correctly
        // Center is a layout widget. It takes a single child and positions it in the middle of the parent.
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              //mainAxisAlignment centers the children vertically
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/background_no_text.jpg')
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
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
                            _back();
                          }
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Please enter the following information:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'First name',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _firstNameController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a first name";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Last name',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _lastNameController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a last name";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _emailController,
                            validator: (text) {
                              if(!text.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _passwordController,
                            validator: (text) {
                              if(text.length < 6) {
                                return 'Password must be atleast 6 characters long';
                              }
                              return null;
                            },
                            obscureText: true,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _password2Controller,
                            obscureText: true,
                            textCapitalization: TextCapitalization.words,
                            validator: (text) {
                              if(_passwordController.text != _password2Controller.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'City',
                              prefixIcon: Icon(Icons.edit_location),
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
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Country',
                              prefixIcon: Icon(Icons.edit_location),
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
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Bio',
                              prefixIcon: Icon(Icons.perm_device_information),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _bioController,
                            maxLines: 3,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                  child: MaterialButton(
                    onPressed: _chooseImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: MediaQuery.of(context).size.width / 4.8,
                      child: (_imageFile == null) ? Icon(Icons.add) : CircleAvatar(
                        backgroundImage: FileImage(_imageFile),
                        radius: MediaQuery.of(context).size.width / 5,
                      ),
                    ),
                  ),
                ),
                showAlert(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 40, 25, 35),
                  //padding: const EdgeInsets.only(top: 40.0, bottom: 35.0,),
                  child: MaterialButton(
                    onPressed: () {
                      _submit();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.blue,
                    //We get the height of the screen so the buttons adjust to size of phone
                    height: MediaQuery.of(context).size.height / 15,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
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

  //this method is used to display an alert to the user
  //in this class it displays the error message when connecting to firebase
  Widget showAlert() {
    //if an error is present
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                //displays the error
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(height: 0,);
  }
}
