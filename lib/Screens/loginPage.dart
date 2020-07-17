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
  //a key is the identifier for widgets
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //providing a global key to the form uniquely identifies the form and allows validation
  final _formKey = GlobalKey<FormState>();
  //text editing controllers to get text in the text fields
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //the following function helps navigate to the signUp Page when user clicks Sign Up button
  void _signUp() {
    /*if(_formKey.currentState.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      AppConstants.currentUser = User();
      AppConstants.currentUser.email = email;
      AppConstants.currentUser.password = password;
      Navigator.pushNamed(context, SignUpPage.routeName);
    }*/
    //we don't validate this form instead we just go to the signUp page
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
        //loads all info other than reviews and conversation since that is stream builder
        AppConstants.currentUser.getPersonalInfoFromFirestore().whenComplete(() {
          Navigator.pushNamed(context, GuestHomePage.routeName);
        });
      });
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
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/finalBackground.jpg')
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*Text(
                    'Welcome to ${AppConstants.appName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),*/
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 5, 50 , 10),
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
                          padding: const EdgeInsets.fromLTRB(50, 0, 50 , 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Password'
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
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 35, 25 , 5),
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
                    padding: const EdgeInsets.fromLTRB(50, 0, 50 , 50),
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
      ),
      );
  }
}
