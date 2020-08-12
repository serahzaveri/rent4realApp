import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Screens/hostHomePage.dart';
import 'package:househunter/Screens/myPostingsPage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_select/smart_select.dart';
import 'package:househunter/Models/options.dart' as options;

class CreatePostingPage extends StatefulWidget {

  final Posting posting;

  static final String routeName = '/createPostingPageRoute';

  CreatePostingPage({this.posting, Key key}) : super(key: key);

  @override
  _CreatePostingPageState createState() => _CreatePostingPageState();
}

class _CreatePostingPageState extends State<CreatePostingPage> {


  final _formKey = GlobalKey<FormState>();
  TextEditingController _priceController;
  TextEditingController _apartmentNumberController;
  TextEditingController _streetNumberController;
  TextEditingController _streetNameController;
  TextEditingController _cityController;
  TextEditingController _countryController;
  TextEditingController _zipCodeController;
  TextEditingController _bedroomsController; //text editing controller added
  int _bedroomsVar;
  String _houseType;
  String _personalTitle;
  String _leaseStart;
  String _leaseEnd;
  String _flexibleDates;
  String _leasePeriod;
  String _walkingTime;
  String _busTime;
  String _trainTime;
  String _washerDryer;
  List<String> _amenities;
  String _furnished;
  Map<String, int> _bathrooms;
  List<MemoryImage> _images;

  void _selectImage(int index) async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      MemoryImage newImage = MemoryImage(imageFile.readAsBytesSync());
      if(index < 0) {
        _images.add(newImage);
      } else {
        _images[index] = newImage;
      }
      setState(() {});
    }
  }

  void _savePosting() {
    if(!_formKey.currentState.validate()) {return;}
    if(_houseType == null) {return;}
    if(_leasePeriod == null) {return;}
    if(_furnished == null) {return;}
    if(_images.isEmpty) {return;}
    Posting posting = Posting();
    posting.price = double.parse(_priceController.text);
    posting.apartmentNumber = _apartmentNumberController.text;
    posting.streetNumber = int.parse(_streetNumberController.text);
    posting.address = _streetNameController.text;
    posting.city = _cityController.text;
    posting.country = _countryController.text;
    posting.zipCode = _zipCodeController.text;
    posting.amenities = _amenities;
    posting.type = _houseType;
    posting.furnished = _furnished;
    posting.bedrooms = int.parse(_bedroomsController.text);
    posting.bathrooms = _bathrooms;
    posting.displayImages = _images;
    posting.host = AppConstants.currentUser.createContactFromUser();
    posting.personalTitle = _personalTitle;
    posting.leaseStart = _leaseStart;
    posting.leaseEnd = _leaseEnd;
    posting.flexibleDates = _flexibleDates;
    posting.walkingTime = _walkingTime;
    posting.busTime = _busTime;
    posting.trainTime = _trainTime;
    posting.washerDryer = _washerDryer;
    posting.setImageNames();
    if(widget.posting == null) {
      posting.rating = 2.5;
      posting.bookings = [];
      posting.reviews = [];
      posting.addPostingInfoToFirestore().whenComplete(() {
        posting.addImagesToFirestore().whenComplete(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HostHomePage(index: 1,)),
          );
        });
      });
    } else {
      posting.rating = widget.posting.rating;
      posting.bookings = widget.posting.bookings;
      posting.reviews = widget.posting.reviews;
      posting.id = widget.posting.id;
      for (int i=0; i < AppConstants.currentUser.myPostings.length; i++) {
        if(AppConstants.currentUser.myPostings[i].id == posting.id) {
          AppConstants.currentUser.myPostings[i] = posting;
          break;
        }
      }
      posting.updatePostingInfoInFirestore().whenComplete(() {
        posting.addImagesToFirestore().whenComplete(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HostHomePage(index: 1,)),
          );
        });
      });
    }
  }

  void _setUpInitialValues() {
    if(widget.posting == null) {
      _priceController = TextEditingController();
      _bedroomsController = TextEditingController();
      _apartmentNumberController = TextEditingController();
      _streetNumberController = TextEditingController();
      _streetNameController = TextEditingController();
      _cityController = TextEditingController();
      _countryController = TextEditingController();
      _zipCodeController = TextEditingController();
      _bedroomsVar = 0;
      _bathrooms = {
        'full': 0,
        'half': 0,
      };
      _images = [];
      _amenities = [];
      _houseType = "";
      _personalTitle = "";
      _leaseStart = "";
      _leaseEnd = "";
      _flexibleDates = "";
      _leasePeriod = "";
      _furnished = "";
      _walkingTime = "";
      _busTime = "";
      _trainTime = "";
      _washerDryer = "";
    } else {
      _priceController = TextEditingController(text: widget.posting.price.toString());
      _apartmentNumberController = TextEditingController(text: widget.posting.apartmentNumber);
      _streetNameController = TextEditingController(text: widget.posting.address);
      _cityController = TextEditingController(text: widget.posting.city);
      _countryController = TextEditingController(text: widget.posting.country);
      _zipCodeController = TextEditingController(text: widget.posting.zipCode);
      _streetNumberController = TextEditingController(text: widget.posting.streetNumber.toString());
      _amenities = widget.posting.getAmenitiesString();
      _bedroomsController = TextEditingController(text: widget.posting.bedrooms.toString());
      _bathrooms = widget.posting.bathrooms;
      _images = widget.posting.displayImages;
      _houseType = widget.posting.type;
      _furnished = widget.posting.furnished;
      _leasePeriod = widget.posting.leaseType;
      _personalTitle = widget.posting.personalTitle;
      _leaseStart = widget.posting.leaseStart;
      _leaseEnd = widget.posting.leaseEnd;
      _flexibleDates = widget.posting.flexibleDates;
      _walkingTime = widget.posting.walkingTime;
      _busTime = widget.posting.busTime;
      _trainTime = widget.posting.trainTime;
      _washerDryer = widget.posting.washerDryer;
    }
    setState(() {});
  }

  @override
  void initState() {
    _setUpInitialValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Create a Posting'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it in the middle of the parent.
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
            child: Column(
              //mainAxisAlignment centers the children vertically
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Please enter the following information:',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: SmartSelect<String>.single(
                            title: "Your title",
                            value: this._personalTitle,
                            options: options.personalTitle,
                            onChange: (val) => setState(() => this._personalTitle = val),
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: const Icon(Icons.person),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SmartSelect<String>.single(
                            title: "Type of Place",
                            value: this._houseType,
                            options: options.houseType,
                            onChange: (val) => setState(() => this._houseType = val),
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: const Icon(Icons.home),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SmartSelect<String>.single(
                            title: "Is the apartment furnished?",
                            value: this._furnished,
                            options: options.furnished,
                            onChange: (val) => setState(() => this._furnished = val),
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: const Icon(Icons.hotel),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SmartSelect<String>.single(
                            title: "Lease start month",
                            value: this._leaseStart,
                            options: options.months,
                            onChange: (val) => setState(() => this._leaseStart = val),
                            leading: const Icon(Icons.calendar_today),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SmartSelect<String>.single(
                            title: "Lease end month",
                            value: this._leaseEnd,
                            options: options.months,
                            onChange: (val) => setState(() => this._leaseEnd = val),
                            leading: const Icon(Icons.calendar_today),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SmartSelect<String>.single(
                            title: "Are you flexible with the lease dates?",
                            value: this._flexibleDates,
                            options: options.flexibleDates,
                            onChange: (val) => setState(() => this._flexibleDates = val),
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: const Icon(Icons.description),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Rent',
                                      prefixIcon: Icon(Icons.attach_money)
                                  ),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: _priceController,
                                  validator: (text) {
                                    if(text.isEmpty) {
                                      return "Please enter a price";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, bottom: 15.0),
                                child: Text(
                                  '/ per month',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: SmartSelect<String>.single(
                            title: "Time to walk to McGill campus",
                            value: this._walkingTime,
                            options: options.distanceTime,
                            onChange: (val) => setState(() => this._walkingTime = val),
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: const Icon(Icons.directions_walk),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: SmartSelect<String>.single(
                            title: "Bus ride to McGill campus",
                            value: this._busTime,
                            options: options.distanceTime,
                            onChange: (val) => setState(() => this._busTime = val),
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: const Icon(Icons.directions_bus),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: SmartSelect<String>.single(
                            title: "Train ride to McGill campus",
                            value: this._trainTime,
                            options: options.distanceTime,
                            onChange: (val) => setState(() => this._trainTime = val),
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: const Icon(Icons.train),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Apartment Number'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _apartmentNumberController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter an apartment number";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Street Number'
                            ),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _streetNumberController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a street number";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Street Name'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _streetNameController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter an address";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'City'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _cityController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a city";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Country'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _countryController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter a country";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Zip Code'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _zipCodeController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter the zip code";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 5.0),
                          child: FacilitiesWidget(
                            type: 'Total Bedrooms',
                            startValue: 0,
                            decreaseValue: () {
                              _bedroomsVar--;
                              this._bedroomsController.text = _bedroomsVar.toString();
                              if(this._bedroomsVar < 0) {
                                this._bedroomsVar = 0;
                                this._bedroomsController.text = _bedroomsVar.toString();
                              }
                            },
                            increaseValue: () {
                              _bedroomsVar++;
                              this._bedroomsController.text = _bedroomsVar.toString();
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 5.0),
                            child: Text(
                              'Bathrooms',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                            child: Column(
                              children: <Widget>[
                                FacilitiesWidget(
                                  type: 'Half',
                                  startValue: _bathrooms['half'],
                                  decreaseValue: () {
                                    this._bathrooms['half']--;
                                    if(this._bathrooms['half'] < 0) {
                                      this._bathrooms['half'] = 0;
                                    }
                                  },
                                  increaseValue: () {
                                    this._bathrooms['half']++;
                                  },
                                ),
                                FacilitiesWidget(
                                  type: 'Full',
                                  startValue: _bathrooms['full'],
                                  decreaseValue: () {
                                    this._bathrooms['full']--;
                                    if(this._bathrooms['full'] < 0) {
                                      this._bathrooms['full'] = 0;
                                    }
                                  },
                                  increaseValue: () {
                                    this._bathrooms['full']++;
                                  },
                                ),
                              ],
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: SmartSelect<String>.single(
                            title: "Washer & Dryer",
                            value: this._washerDryer,
                            options: options.dryerWasher,
                            onChange: (val) => setState(() => this._washerDryer = val),
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: const Icon(Icons.local_laundry_service),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: SmartSelect<String>.multiple(
                            title: 'Amenities',
                            value: _amenities,
                            isTwoLine: true,
                            options: options.amenities,
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: const Icon(Icons.filter_frames),
                            onChange: (val) => setState(() => _amenities = val),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: Text(
                              'Images',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: _images.length + 1,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 25,
                                crossAxisSpacing: 25,
                                childAspectRatio: 3/2,
                              ),
                              itemBuilder: (context, index) {
                                if(index == _images.length) {
                                  return IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        _selectImage(-1);
                                      },
                                    );
                                }
                                return MaterialButton(
                                  onPressed: () {
                                    _selectImage(index);
                                  } ,
                                  child: Image(
                                    image: _images[index],
                                    fit: BoxFit.fill,
                                  ),
                                );
                              }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 40, 25, 35),
                          //padding: const EdgeInsets.only(top: 40.0, bottom: 35.0,),
                          child: MaterialButton(
                            onPressed: () {
                              _savePosting();
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

class FacilitiesWidget extends StatefulWidget {

  final String type;
  final int startValue;
  final Function decreaseValue;
  final Function increaseValue;

  FacilitiesWidget({Key key, this.type, this.startValue, this.decreaseValue, this.increaseValue}): super(key: key);

  @override
  _FacilitiesWidgetState createState() => _FacilitiesWidgetState();

}

class _FacilitiesWidgetState extends State<FacilitiesWidget> {

  int _value;

  @override
  void initState() {
    this._value = widget.startValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.type,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  widget.decreaseValue();
                  this._value--;
                  if(this._value < 0) {
                    this._value = 0;
                  }
                  setState(() {});
                },
            ),
            Text(
              this._value.toString(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                widget.increaseValue();
                this._value++;
                setState(() {});
              },
            ),
          ],
        )
      ],
    );
  }

}
