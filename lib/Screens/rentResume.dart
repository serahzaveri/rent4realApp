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
  DateTime _selectedDate;
  String _dob;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _contactNumberController = TextEditingController();
  String _gender;
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
    if(_firstNameController.text != ""){
      _progressBar += 2;
    }
    if(_lastNameController.text != ""){
      _progressBar += 3;
    }
    if(_emailController.text != ""){
      _progressBar += 5;
    }
    if(_contactNumberController.text != ""){
      _progressBar += 5;
    }
    if(_dob != null){
      _progressBar += 5;
    }
    if(_gender != null){
      _progressBar += 5;
    }
    if(_schoolController.text != ""){
      _progressBar += 5;
    }
    if(_programController.text != ""){
      _progressBar += 5;
    }
    if(_yearController.text != ""){
      _progressBar += 5;
    }
    if(_homeCountryController.text != ""){
      _progressBar += 5;
    }
    if(_emergencyContactNameController.text != ""){
      _progressBar += 5;
    }
    if(_emergencyContactNumberController.text != ""){
      _progressBar += 5;
    }
    if(_relationshipController.text != ""){
      _progressBar += 5;
    }
    if(_presentAddressController.text != ""){
      _progressBar += 5;
    }
    if(_presentRentController.text != ""){
      _progressBar += 5;
    }
    if(_presentLandlordNameController.text != ""){
      _progressBar += 5;
    }
    if(_presentLandlordNameController.text != ""){
      _progressBar += 5;
    }
    if(_priorLandlordNameController.text != ""){
      _progressBar += 5;
    }
    if(_priorLandlordNumberController.text != ""){
      _progressBar += 5;
    }
    if(_priorRentController.text != ""){
      _progressBar += 5;
    }
    if(_priorAddressController.text != ""){
      _progressBar += 5;
    }
  }

  void _saveInfo() {
    //if(!_formKey.currentState.validate()) {return ;}
    AppConstants.currentUser.firstName = _firstNameController.text;
    AppConstants.currentUser.lastName = _lastNameController.text;
    AppConstants.currentUser.email = _emailController.text;
    AppConstants.currentUser.contactNumber = _contactNumberController.text;
    AppConstants.currentUser.dateOfBirth = _dob;
    AppConstants.currentUser.gender = _gender;
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
    AppConstants.progressUpdate = _progressBar;
    setState(() {});
    AppConstants.currentUser.addRentResumeToFirestore().whenComplete(() {
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960, 8),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  void initState() {
    _firstNameController = TextEditingController(text: AppConstants.currentUser.firstName);
    _lastNameController = TextEditingController(text: AppConstants.currentUser.lastName);
    _emailController = TextEditingController(text: AppConstants.currentUser.email);
    _contactNumberController = TextEditingController(text: AppConstants.currentUser.contactNumber);
    _dob = AppConstants.currentUser.dateOfBirth;
    _gender = AppConstants.currentUser.gender;
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
          icon: Icon(Icons.arrow_back, color: Colors.deepOrange, size: 25.0),
          onPressed: (){
            _saveInfo();
            Navigator.pushNamed(context, GuestHomePage.routeName);
          }
        ),
        title: Text(
          'My Rent Resume',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          )
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          MaterialButton(
            onPressed: _saveInfo,
            color: Colors.deepOrange,
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
          ),
          //IconButton(icon: Icon(Icons.save, color: Colors.blue), onPressed: _saveInfo)
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 25, 40, 0),
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
                            width: MediaQuery.of(context).size.width - 100,
                            animation: true,
                            animationDuration: 2000,
                            lineHeight: 20.0,
                            percent: AppConstants.currentUser.getProgressBar2(),
                            center: Text(
                              '${(_progressBar).toString()} %',
                              style: new TextStyle(fontSize: 12.0),
                            ),
                            backgroundColor: Colors.grey,
                            progressColor: Colors.redAccent,
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
                              fontSize: 18.0,
                            ),
                            controller: _firstNameController,
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
                              fontSize: 18.0,
                            ),
                            controller: _lastNameController,
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
                              fontSize: 18.0,
                            ),
                            enabled: false,
                            controller: _emailController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            'Email ID cant be changed',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Cell Phone',
                              icon: const Icon(Icons.phone),
                            ),
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _contactNumberController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Icon(Icons.calendar_today, color: Colors.black45,),
                              ),
                              _dob == null ? Text(
                                'Date of Birth',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black54,
                                ),
                              ) : Text(
                                _dob,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Spacer(),
                              RaisedButton(
                                onPressed: () {
                                  _selectDate(context).whenComplete(() {
                                    _dob = _selectedDate.toLocal().toString().split(' ')[0];
                                  });
                                },
                                child: Text('Select date'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 25.0),
                          child: new DropdownButtonFormField<String>(
                            hint: _gender == null
                                ? Text(
                              'Pick Gender',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ) : Text(
                              'Gender:  $_gender',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            validator: (_gender) => _gender == null ? 'field required' : null,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 18,
                            onChanged: (String newValue) {setState(() {
                              _gender = newValue;
                            });},
                            items: <String>['Cis male', 'Cis female', 'Transgender', 'Intersex', 'Non-binary', 'Other', 'Prefer not to say'].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
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
                              fontSize: 18.0,
                            ),
                            controller: _schoolController,
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
                              fontSize: 18.0,
                            ),
                            controller: _programController,
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
                              fontSize: 18.0,
                            ),
                            controller: _yearController,
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
                              fontSize: 18.0,
                            ),
                            controller: _homeCountryController,
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
                              fontSize: 18.0,
                            ),
                            controller: _emergencyContactNameController,
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
                              fontSize: 18.0,
                            ),
                            controller: _relationshipController,
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
                              fontSize: 18.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _emergencyContactNumberController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text(
                            'If you are living with your parents write parents address and rent as 0. Also add parents name and number for landlord details',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Present address',
                              icon: const Icon(Icons.add_location),
                            ),
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            controller: _presentAddressController,
                            maxLines: 3,
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
                              fontSize: 18.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _presentRentController,
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
                              fontSize: 18.0,
                            ),
                            controller: _presentLandlordNameController,
                            textCapitalization: TextCapitalization.words,
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
                              fontSize: 18.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _presentLandlordNumberController,
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
                              fontSize: 18.0,
                            ),
                            controller: _priorAddressController,
                            maxLines: 3,
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
                              fontSize: 18.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _priorRentController,
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
                              fontSize: 18.0,
                            ),
                            controller: _priorLandlordNameController,
                            textCapitalization: TextCapitalization.words,
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
                              fontSize: 18.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _priorLandlordNumberController,
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