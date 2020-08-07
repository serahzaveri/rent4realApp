import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Screens/accountPage.dart';
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
  TextEditingController _contactNumberController;
  TextEditingController _dateOfBirthController;
  TextEditingController _genderController;
  TextEditingController _schoolController;
  TextEditingController _programController;
  TextEditingController _yearController;
  TextEditingController _homeCountryController;
  TextEditingController _emergencyContactNameController;
  TextEditingController _emergencyContactNumberController;
  TextEditingController _presentAddressController;
  TextEditingController _priorAddressController;
  TextEditingController _presentRentController;
  TextEditingController _presentLandlordNameController;
  TextEditingController _presentLandlordNumberController;
  TextEditingController _priorLandlordNameController;
  TextEditingController _priorLandlordNumberController;
  TextEditingController _priorRentController;
  TextEditingController _relationshipController;


  void _saveInfo() {
    if(!_formKey.currentState.validate()) {return ;}
    AppConstants.currentUser.firstName = _firstNameController.text;
    AppConstants.currentUser.lastName = _lastNameController.text;
    AppConstants.currentUser.city = _emergencyContactNameController.text;
    AppConstants.currentUser.country = _emergencyContactNumberController.text;
    /*AppConstants.currentUser.updateUserInFirestore().whenComplete(() {
      Navigator.pushNamed(context, GuestHomePage.routeName);
    });*/
  }

  @override
  void initState() {

    _firstNameController = TextEditingController(text: AppConstants.currentUser.firstName);
    _lastNameController = TextEditingController(text: AppConstants.currentUser.lastName);
    _emailController = TextEditingController(text: AppConstants.currentUser.email);
    /*_emergencyContactNameController = TextEditingController(text: AppConstants.currentUser.city);
    _emergencyContactNumberController = TextEditingController(text: AppConstants.currentUser.country);
    _presentAddressController = TextEditingController(text: AppConstants.currentUser.bio);*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'My Rent Resume'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save, color: Colors.white), onPressed: _saveInfo)
        ],
      ),
      body: Center(
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
                              labelText: 'First name',
                              icon: const Icon(Icons.person),
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
                              labelText: 'Last name',
                              icon: const Icon(Icons.person),
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
                              labelText: 'Email ID',
                              icon: const Icon(Icons.mail_outline),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid email ID";
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
                              labelText: 'Cell Phone',
                              icon: const Icon(Icons.phone),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _contactNumberController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid contact number";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                              icon: const Icon(Icons.calendar_today),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _dateOfBirthController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid date of birth";
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
                                labelText: 'Gender',
                              icon: const Icon(Icons.arrow_drop_down),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _genderController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please choose an option";
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
                              labelText: 'School Attending',
                              icon: const Icon(Icons.school),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _schoolController,
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
                              labelText: 'Program',
                              icon: const Icon(Icons.school),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _programController,
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
                              labelText: 'Year of School',
                              icon: const Icon(Icons.school),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _yearController,
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
                                labelText: 'Home Country',
                              icon: const Icon(Icons.local_airport),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _homeCountryController,
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
                              labelText: 'Emergency Contact Name',
                              icon: const Icon(Icons.warning),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _emergencyContactNameController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid emergency contact";
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
                              labelText: 'Relationship',
                              icon: const Icon(Icons.person_pin),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _relationshipController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid relationship to emergency contact";
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
                              labelText: 'Emergency Contact number',
                              icon: const Icon(Icons.warning),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _emergencyContactNumberController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid contact number";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Present address',
                              icon: const Icon(Icons.add_location),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _presentAddressController,
                            maxLines: 3,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid present address";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Present Rent',
                              icon: const Icon(Icons.attach_money),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _presentRentController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid rent amount";
                              }
                              return null;
                            },

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Landlords Name',
                              icon: const Icon(Icons.person_pin),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _presentLandlordNameController,
                            maxLines: 3,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid prior address";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Landlords Number',
                              icon: const Icon(Icons.phone),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _presentLandlordNumberController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid number";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Prior address',
                              icon: const Icon(Icons.add_location),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _priorAddressController,
                            maxLines: 3,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid prior address";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Prior Rent',
                              icon: const Icon(Icons.attach_money),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _priorRentController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid rent amount";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Landlords Name',
                              icon: const Icon(Icons.person_pin),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _priorLandlordNameController,
                            maxLines: 3,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid prior address";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Landlords Number',
                              icon: const Icon(Icons.phone),
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _priorLandlordNumberController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a valid number";
                              }
                              return null;
                            },
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