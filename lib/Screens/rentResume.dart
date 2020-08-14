import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Screens/accountPage.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class RentResumePage extends StatefulWidget {

  static final String routeName = '/rentResumePageRoute';

  RentResumePage({Key key}) : super(key: key);

  @override
  _RentResumePagePageState createState() => _RentResumePagePageState();
}

class _RentResumePagePageState extends State<RentResumePage> {

  final _formKey = GlobalKey<FormState>();
  int _progressBar =  0;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _schoolController = TextEditingController();
  TextEditingController _programController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _homeCountryController = TextEditingController();
  TextEditingController _emergencyContactNameController = TextEditingController();
  TextEditingController _emergencyContactNumberController = TextEditingController();
  TextEditingController _relationshipController = TextEditingController();
  TextEditingController _presentAddressController = TextEditingController();
  TextEditingController _presentRentController = TextEditingController();
  TextEditingController _presentLandlordNameController = TextEditingController();
  TextEditingController _presentLandlordNumberController = TextEditingController();
  TextEditingController _priorAddressController = TextEditingController();
  TextEditingController _priorLandlordNameController = TextEditingController();
  TextEditingController _priorLandlordNumberController = TextEditingController();
  TextEditingController _priorRentController = TextEditingController();

  void _checkProgress() {
    _progressBar = 0;
    if(_lastNameController.text != ""){
      _progressBar += 5;
    }
    if(_emailController.text != ""){
      _progressBar += 5;
    }
    if(_contactNumberController.text != ""){
      _progressBar += 5;
    }
    if(_schoolController.text != ""){
      _progressBar += 5;
    }
    if(_emergencyContactNameController.text != ""){
      _progressBar += 5;
    }
    if(_presentAddressController.text != ""){
      _progressBar += 5;
    }
    if(_priorLandlordNameController.text != ""){
      _progressBar += 5;
    }
  }

  void _saveInfo() {
    //if(!_formKey.currentState.validate()) {return ;}
    AppConstants.currentUser.firstName = _firstNameController.text;
    AppConstants.currentUser.lastName = _lastNameController.text;
    AppConstants.currentUser.email = _emailController.text;
    AppConstants.currentUser.contactNumber = _contactNumberController.text;
    AppConstants.currentUser.dateOfBirth = _dateOfBirthController.text;
    AppConstants.currentUser.gender = _genderController.text;
    AppConstants.currentUser.school = _schoolController.text;
    AppConstants.currentUser.program = _programController.text;
    AppConstants.currentUser.yearOfSchool = _yearController.text;
    AppConstants.currentUser.homeCountry = _homeCountryController.text;
    AppConstants.currentUser.emergencyContactName = _emergencyContactNameController.text;
    AppConstants.currentUser.emergencyContactNumber = _emergencyContactNumberController.text;
    AppConstants.currentUser.emergencyContactRelationship = _relationshipController.text;
    AppConstants.currentUser.presentAddress = _presentAddressController.text;
    AppConstants.currentUser.presentRent = _presentRentController.text;
    AppConstants.currentUser.presentLandlordName = _presentLandlordNameController.text;
    AppConstants.currentUser.presentLandlordNumber = _presentLandlordNumberController.text;
    AppConstants.currentUser.priorAddress = _priorAddressController.text;
    AppConstants.currentUser.priorRent = _priorRentController.text;
    AppConstants.currentUser.priorLandlordName = _priorLandlordNameController.text;
    AppConstants.currentUser.priorLandlordNumber = _priorLandlordNumberController.text;
    _checkProgress();
    AppConstants.currentUser.progressBar = _progressBar;
    AppConstants.currentUser.addRentResumeToFirestore().whenComplete(() {
    });
    Navigator.pushNamed(context, GuestHomePage.routeName);
  }

  @override
  void initState() {
    _firstNameController = TextEditingController(text: AppConstants.currentUser.firstName);
    _lastNameController = TextEditingController(text: AppConstants.currentUser.lastName);
    _emailController = TextEditingController(text: AppConstants.currentUser.email);
    _contactNumberController = TextEditingController(text: AppConstants.currentUser.contactNumber);
    _dateOfBirthController = TextEditingController(text: AppConstants.currentUser.dateOfBirth);
    _genderController = TextEditingController(text: AppConstants.currentUser.gender);
    _schoolController = TextEditingController(text: AppConstants.currentUser.school);
    _programController = TextEditingController(text: AppConstants.currentUser.program);
    _yearController = TextEditingController(text: AppConstants.currentUser.yearOfSchool);
    _homeCountryController = TextEditingController(text: AppConstants.currentUser.homeCountry);
    _emergencyContactNameController = TextEditingController(text: AppConstants.currentUser.emergencyContactName);
    _emergencyContactNumberController = TextEditingController(text: AppConstants.currentUser.emergencyContactName);
    _relationshipController = TextEditingController(text: AppConstants.currentUser.emergencyContactRelationship);
    _presentAddressController = TextEditingController(text: AppConstants.currentUser.presentAddress);
    _presentRentController = TextEditingController(text: AppConstants.currentUser.presentRent);
    _presentLandlordNameController = TextEditingController(text: AppConstants.currentUser.presentLandlordName);
    _presentLandlordNumberController = TextEditingController(text: AppConstants.currentUser.presentLandlordNumber);
    _priorAddressController = TextEditingController(text: AppConstants.currentUser.priorAddress);
    _priorRentController = TextEditingController(text: AppConstants.currentUser.priorRent);
    _priorLandlordNameController = TextEditingController(text: AppConstants.currentUser.priorLandlordName);
    _priorLandlordNumberController = TextEditingController(text: AppConstants.currentUser.priorLandlordNumber);
    _progressBar = AppConstants.currentUser.progressBar;
    super.initState();
    //the below code edits the progress bar after the form has been loaded
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _checkProgress());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: (){
            Navigator.pushNamed(context, GuestHomePage.routeName);
          }
          //onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'My Rent Resume',
          style: TextStyle(
            color: Colors.black,
          )
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save, color: Colors.blue), onPressed: _saveInfo)
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
                          padding: const EdgeInsets.all(10.0),
                          child: new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 80,
                            animation: true,
                            animationDuration: 2000,
                            lineHeight: 20.0,
                            percent: AppConstants.currentUser.getProgressBar2(),
                            center: Text(
                              '${(_progressBar).toString()} %',
                              style: new TextStyle(fontSize: 12.0),
                            ),
                            backgroundColor: Colors.grey,
                            progressColor: Colors.blue,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
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
                              labelText: 'Relationship to Emergency Contact',
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
                          padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
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