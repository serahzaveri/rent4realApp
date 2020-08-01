import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/sharedPreferencesHelper.dart';
import 'package:househunter/Models/userObjects.dart';
import 'package:househunter/Screens/forgotPasswordPage.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Screens/signUpPage.dart';
import 'dart:io' show Platform;

class LoginPage extends StatefulWidget {

  static final String routeName = '/loginPageRoute';
  //a key is the identifier for widgets
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _error;
  //providing a global key to the form uniquely identifies the form and allows validation
  final _formKey = GlobalKey<FormState>();
  //text editing controllers to get text in the text fields
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //the following function helps navigate to the signUp Page when user clicks Sign Up button
  void _signUp() {
    //we don't validate this form instead we just go to the signUp page
    Navigator.pushNamed(context, SignUpPage.routeName);
  }

  void _forgotPassword() {
    //we don't validate this form instead we just go to the signUp page
    Navigator.pushNamed(context, ForgotPasswordPage.routeName);
  }

  //the following function helps navigate to the Login Page when user clicks Login button
  void _signIn() async {
    //we reset errorMessage every time login is pressed
    FirebaseUser firebaseUser;
    //if the fields of the form are filled
    if(_formKey.currentState.validate()){
      String email = _emailController.text;
      String password = _passwordController.text;
      try {
        firebaseUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print("no error detected");
        //this is to keep the user logged in using shared preferences
        SharedPreferencesHelper.saveUserLoggedInSharedPreference(true);
        String userID = firebaseUser.uid;
        SharedPreferencesHelper.saveUserIdSharedPreference(userID);
        AppConstants.currentUser = User(id: userID);
        //loads all info other than reviews and conversation since that is stream builder
        AppConstants.currentUser.getPersonalInfoFromFirestore().whenComplete(() {
          Navigator.pushNamed(context, GuestHomePage.routeName);
        });
      } catch(error) {
        setState(() {
          _error = error.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                //mainAxisAlignment centers the children vertically
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //if an alert is present and set state is called it displays the error message to the user
                  showAlert(),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/finalBackground.jpg')
                        ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 5, 50 , 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email / Username',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            validator: (text) {
                              if(!text.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            controller: _emailController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 50 , 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            //obscure text hides the text for password
                            obscureText: true,
                            validator: (text) {
                              if(text.length < 6) {
                                return 'Password must be atleast 6 characters long';
                              }
                              return null;
                            },
                            controller: _passwordController,
                          ),
                        )
                      ],
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 25 , 5),
                    child: MaterialButton(
                      onPressed: () {
                        _signIn();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      color: Colors.lightBlue,
                      //We get the height of the screen so the buttons adjust to size of phone
                      height: MediaQuery.of(context).size.height / 15,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50 , 0),
                    child: MaterialButton(
                      onPressed: () {
                        _signUp();
                        },
                      child: Text(
                        'Dont have an account? Sign Up',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      //color: Colors.grey,
                      //We get the height of the screen so the buttons adjust to size of phone
                      height: MediaQuery.of(context).size.height / 17,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50 , 0),
                    child: MaterialButton(
                      onPressed: () {
                        _forgotPassword();
                      },
                      child: Text(
                        'Forgot Passsword',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      //color: Colors.grey,
                      //We get the height of the screen so the buttons adjust to size of phone
                      height: MediaQuery.of(context).size.height / 18,
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
        padding: EdgeInsets.all(10.0),
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
