import 'package:auto_size_text/auto_size_text.dart';
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

  String _error;

  //providing a global key to the form uniquely identifies the form and allows validation
  final _formKey = GlobalKey<FormState>();

  //text editing controllers to get text in the text fields
  TextEditingController _emailController = TextEditingController();

  //the following function helps navigate to the signUp Page when user clicks Sign Up button
  void _back() {
    //we don't validate this form instead we just go to the signUp page
    Navigator.pushNamed(context, LoginPage.routeName);
  }

  // Reset Password
  Future<void> sendPasswordResetEmail(String email) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  void _submit() async {
    //after validating form an alert dialog is shown to confirm that password reset email has been sent
    if (_formKey.currentState.validate()) {
      showAlertDialog(context);
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
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/finalCropped.jpg')
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                showAlert(),
                Container(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 30, 50, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              //fillColor: Colors.white,
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.person_outline),
                              ),
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            validator: (text) {
                              if (!text.contains('@')) {
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
                  padding: const EdgeInsets.fromLTRB(20, 30, 25, 5),
                  child: MaterialButton(
                    onPressed: () {
                      _submit();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.deepOrangeAccent,
                    //We get the height of the screen so the buttons adjust to size of phone
                    height: MediaQuery.of(context).size.height / 18,
                    minWidth: double.infinity,
                    //shape of the submit button
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        //colors of border of the button
                        /*side: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                          style: BorderStyle.solid,
                        )*/
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 25, 5),
                  child: MaterialButton(
                    onPressed: () {
                      _back();
                    },
                    child: Text(
                      'Back to Sign In Page',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
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

  // if there is an error while sending reset email
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

  //send email link and navigate back to login page
  sendLink() async{
    try{
      await sendPasswordResetEmail(_emailController.text);
      Navigator.pushNamed(context, LoginPage.routeName);
    } catch(error) {
      setState(() {
        _error = error.message;
      });
    }
  }

  //alert dialog shown to user to acknowledge that reset password email has been sent
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        sendLink();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Reset Password Link"),
      content: Text("Reset Password Link sent to ${_emailController.text}"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}