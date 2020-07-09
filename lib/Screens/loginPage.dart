import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/data.dart';
import 'package:househunter/Models/userObjects.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Screens/signUpPage.dart';

class LoginPage extends StatefulWidget {

  static final String routeName = '/loginPageRoute';

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //the following function helps navigate to the signUp Page when user clicks Sign Up button
  void _signUp() {
    Navigator.pushNamed(context, SignUpPage.routeName);
  }
  //the following function helps navigate to the Login Page when user clicks Login button
  void _login(){
    if(_formKey.currentState.validate()){
      String email = _emailController.text;
      String password = _passwordController.text;
      //here we authenticate the user by checking our database
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      ).then((firebaseUser) {
        String userID = firebaseUser.uid;
        AppConstants.currentUser = User(id: userID);
        //asynchronous function so we use when complete
        AppConstants.currentUser.getUserInfoFromFirestore().whenComplete(() {
          AppConstants.currentUser.getImageFromStorage().whenComplete(() {
            Navigator.pushNamed(context, GuestHomePage.routeName);
          });
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 0),
          child: Column(
            //mainAxisAlignment centers the children vertically
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '${AppConstants.appName}!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email'
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
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password'
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
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
                padding: const EdgeInsets.only(top: 40.0),
                child: MaterialButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text(
                    'Login',
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
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MaterialButton(
                  onPressed: () {
                    _signUp();
                    },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.grey,
                  //We get the height of the screen so the buttons adjust to size of phone
                  height: MediaQuery.of(context).size.height / 15,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
