import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Screens/loginPage.dart';
import 'package:househunter/Screens/signUpPage.dart';


class ForgotPasswordPage extends StatefulWidget {

  static final String routeName = '/forgotPasswordPageRoute';
  //a key is the identifier for widgets
  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  //providing a global key to the form uniquely identifies the form and allows validation
  final _formKey = GlobalKey<FormState>();
  //text editing controllers to get text in the text fields
  TextEditingController _emailController = TextEditingController();

  //the following function helps navigate to the signUp Page when user clicks Sign Up button
  void _back() {
    //we don't validate this form instead we just go to the signUp page
    Navigator.pushNamed(context, LoginPage.routeName);
  }

  void _submit() {
    //we don't validate this form instead we just go to the signUp page
    if(_formKey.currentState.validate()){
      String email = _emailController.text;
      Navigator.pushNamed(context, LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
            child: Column(
              //mainAxisAlignment centers the children vertically
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 70, 50 , 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              //fillColor: Colors.white,
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.person_outline),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 4.0,
                                ),
                              ),
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
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 25 , 5),
                  child: MaterialButton(
                    onPressed: () {
                      _submit();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                    color: Colors.white,
                    //We get the height of the screen so the buttons adjust to size of phone
                    height: MediaQuery.of(context).size.height / 15,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 25 , 5),
                  child: MaterialButton(
                    onPressed: () {
                      _back();
                    },
                    child: Text(
                      'Back to Sign In Page',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
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
}