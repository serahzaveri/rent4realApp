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
  String errorMessage = "";

  //the following function helps navigate to the signUp Page when user clicks Sign Up button
  void _signUp() {
    //we don't validate this form instead we just go to the signUp page
    Navigator.pushNamed(context, SignUpPage.routeName);
  }

  //the following function helps navigate to the Login Page when user clicks Login button
  void _signIn() async {
    //we reset errorMessage every time login is pressed
    errorMessage = "";
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
      } catch(error) {
        // checks all possibles errors on android
        switch (error.code) {
          case "ERROR_INVALID_EMAIL":
            errorMessage = "Your email address appears to be malformed. Please try again! ";
            print(errorMessage);
            break;
          case "ERROR_WRONG_PASSWORD":
            errorMessage = "Your password is wrong. Please try again! ";
            print(errorMessage);
            break;
          case "ERROR_USER_NOT_FOUND":
            errorMessage = "User with this email doesn't exist. Please try again! ";
            print(errorMessage);
            break;
          case "ERROR_USER_DISABLED":
            errorMessage = "User with this email has been disabled. Please try again! ";
            print(errorMessage);
            break;
          case "ERROR_TOO_MANY_REQUESTS":
            errorMessage = "Too many requests. Try again later. Please try again! ";
            print(errorMessage);
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
            errorMessage = "Signing in with Email and Password is not enabled. Please try again! ";
            print(errorMessage);
            break;
          default:
            errorMessage = "An undefined Error happened. Please try again! ";
            print(errorMessage);
            break;
          }
        }
      //if these is an error message then it sets the state to print errorMessage on the screen and then returns
      if(errorMessage != "") {
        setState(() {});
        return;
        }
      //if sign in is successful
      print("no error detected");
      String userID = firebaseUser.uid;
      AppConstants.currentUser = User(id: userID);
      //loads all info other than reviews and conversation since that is stream builder
      AppConstants.currentUser.getPersonalInfoFromFirestore().whenComplete(() {
        Navigator.pushNamed(context, GuestHomePage.routeName);
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
                    padding: const EdgeInsets.fromLTRB(50, 15, 50 , 0),
                    child: Text(
                        errorMessage,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.red,
                        ),
                      ),
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
