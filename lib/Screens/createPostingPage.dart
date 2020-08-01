import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Screens/hostHomePage.dart';
import 'package:househunter/Screens/myPostingsPage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostingPage extends StatefulWidget {

  final Posting posting;

  static final String routeName = '/createPostingPageRoute';

  CreatePostingPage({this.posting, Key key}) : super(key: key);

  @override
  _CreatePostingPageState createState() => _CreatePostingPageState();
}

class _CreatePostingPageState extends State<CreatePostingPage> {

  final List<String> _houseTypes = [
    'Condo',
    'Apartment',
    'Townhouse'
  ];

  final List<String> _isFurnished = [
    'furnished',
    'unfurnished',
    'semi furnished'
  ];

  final List<String> _leaseTypes = [
    '4 month lease',
    '8 month lease',
    '12 month lease',
    '4 or 8 month lease',
    '8 or 12 month lease',
    '4 or 8 or 12 month lease'
  ];

  final _formKey = GlobalKey<FormState>();
  TextEditingController _priceController;
  TextEditingController _descriptionController;
  TextEditingController _apartmentNumberController;
  TextEditingController _streetNumberController;
  TextEditingController _streetNameController;
  TextEditingController _cityController;
  TextEditingController _countryController;
  TextEditingController _amenitiesController;
  TextEditingController _zipCodeController;
  TextEditingController _bedroomsController; //text editing controller added
  int _bedroomsVar;
  String _houseType;
  String _leasePeriod;
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
    posting.description = _descriptionController.text;
    posting.apartmentNumber = _apartmentNumberController.text;
    posting.streetNumber = int.parse(_streetNumberController.text);
    posting.address = _streetNameController.text;
    posting.city = _cityController.text;
    posting.country = _countryController.text;
    posting.zipCode = _zipCodeController.text;
    posting.amenities = _amenitiesController.text.split(",");
    posting.type = _houseType;
    posting.leaseType = _leasePeriod;
    posting.furnished = _furnished;
    posting.bedrooms = int.parse(_bedroomsController.text);
    posting.bathrooms = _bathrooms;
    posting.displayImages = _images;
    posting.host = AppConstants.currentUser.createContactFromUser();
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
      _descriptionController = TextEditingController();
      _apartmentNumberController = TextEditingController();
      _streetNumberController = TextEditingController();
      _streetNameController = TextEditingController();
      _cityController = TextEditingController();
      _countryController = TextEditingController();
      _amenitiesController = TextEditingController();
      _zipCodeController = TextEditingController();
      _bedroomsVar = 0;
      _bathrooms = {
        'full': 0,
        'half': 0,
      };
      _images = [];
    } else {
      _priceController = TextEditingController(text: widget.posting.price.toString());
      _descriptionController = TextEditingController(text: widget.posting.description);
      _apartmentNumberController = TextEditingController(text: widget.posting.apartmentNumber);
      _streetNameController = TextEditingController(text: widget.posting.address);
      _cityController = TextEditingController(text: widget.posting.city);
      _countryController = TextEditingController(text: widget.posting.country);
      _zipCodeController = TextEditingController(text: widget.posting.zipCode);
      _streetNumberController = TextEditingController(text: widget.posting.streetNumber.toString());
      _amenitiesController = TextEditingController(text: widget.posting.getAmenitiesString());
      _bedroomsController = TextEditingController(text: widget.posting.bedrooms.toString());
      _bathrooms = widget.posting.bathrooms;
      _images = widget.posting.displayImages;
      _houseType = widget.posting.type;
      _furnished = widget.posting.furnished;
      _leasePeriod = widget.posting.leaseType;
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
                          child: DropdownButton(
                              //ensures that it takes entire width of screen
                              isExpanded: true,
                              value: _houseType,
                              hint: Text(
                                'Select a house type',
                                style: TextStyle(
                                    fontSize: 20.0,
                                ),
                              ),
                              items: _houseTypes.map((type) {
                                return DropdownMenuItem(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    )
                                );
                              }).toList(),
                              onChanged: (value) {
                                this._houseType = value;
                                setState(() {});
                              },
                          )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: DropdownButton(
                              //ensures that it takes entire width of screen
                              isExpanded: true,
                              value: _leasePeriod,
                              hint: Text(
                                'Lease type',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              items: _leaseTypes.map((type) {
                                return DropdownMenuItem(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    )
                                );
                              }).toList(),
                              onChanged: (value) {
                                this._leasePeriod = value;
                                setState(() {});
                              },
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: DropdownButton(
                              //ensures that it takes entire width of screen
                              isExpanded: true,
                              value: _furnished,
                              hint: Text(
                                'Is the apartment furnished',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              items: _isFurnished.map((type) {
                                return DropdownMenuItem(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    )
                                );
                              }).toList(),
                              onChanged: (value) {
                                this._furnished = value;
                                setState(() {});
                              },
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Rent'
                                  ),
                                  style: TextStyle(
                                    fontSize: 20.0,
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
                                  '\$ / per month',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Distance to campus walking / train'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _descriptionController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter the time it takes to reach campus";
                              }
                              return null;
                            },
                            maxLines: 3,
                            minLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
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
                          padding: const EdgeInsets.only(top: 20.0),
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
                          padding: const EdgeInsets.only(top: 20.0),
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
                          padding: const EdgeInsets.only(top: 20.0),
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
                          padding: const EdgeInsets.only(top: 20.0),
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
                          padding: const EdgeInsets.only(top: 20.0),
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
                          padding: const EdgeInsets.only(top: 35.0),
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
                            padding: const EdgeInsets.only(top: 35.0),
                            child: Text(
                              'Bathrooms',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
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
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Amenities'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            controller: _amenitiesController,
                            validator: (text) {
                              if(text.isEmpty) {
                                return "Please enter amenities (comma separated)";
                              }
                              return null;
                            },
                            maxLines: 3,
                            minLines: 1,
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
