
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Screens/filterPage.dart';
import 'package:househunter/Screens/viewPostingsPage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:househunter/Views/gridWidgets.dart';
import 'package:smart_select/smart_select.dart';
import 'package:househunter/Models/options.dart' as options;

class ExplorePage extends StatefulWidget {

  ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  Stream _stream = Firestore.instance.collection('postings').snapshots();
  String _searchType = "";
  String _searchCategory = "";

  String _houseTypeFilter;
  String _furnishedFilter;
  String _bedroomsFilter;

  void _searchByField() {
    if(_searchType.isEmpty) {
      _stream = Firestore.instance.collection('postings').snapshots();
    } else {
      String text = _searchCategory;
      _stream = Firestore.instance.collection('postings').where(_searchType, isEqualTo: text).snapshots();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  //this padding is between search bar and listing
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Location (currently only available in Montreal)',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black,
                    ),
                    //controller: _controller,
                    //onEditingComplete: _searchByField,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                      'Stays in Montreal',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MaterialButton(
                    onPressed: () {
                      _filterModalBottomSheet(context);
                    },
                    child: Text(
                        "Filters",
                      style: TextStyle(
                        color: Colors.deepOrange
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: Colors.white,
                  ),
                ),
                /*
                Container(
                  height: MediaQuery.of(context).size.height / 14,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                         _pressSearchByButton("name", true, false, false);
                        },
                        child: Text("Name"),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: _isNameButtonSelected ? Colors.grey : Colors.white,
                      ),
                      MaterialButton(
                        onPressed: () {
                          _pressSearchByButton("city", false, true, false);
                        },
                        child: Text("City"),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: _isCityButtonSelected ? Colors.grey : Colors.white,
                      ),
                      MaterialButton(
                        onPressed: () {
                          _pressSearchByButton("type", false, false, true);
                        },
                        child: Text("Type"),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: _isTypeButtonSelected ? Colors.grey : Colors.white,
                      ),
                      MaterialButton(
                        onPressed: () {
                          _pressSearchByButton("", false, false, false);
                        },
                        child: Text("Clear"),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                ),*/
                StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshots) {
                    switch (snapshots.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator(),);
                      default:
                        if(snapshots.data.documents.length == 0) {
                          print('No listings');
                          return Container(
                            child: Text(
                              'No listings found',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          );
                        }
                        return GridView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshots.data.documents.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //cross Axis count tells us the number of listings we want sideways on screen
                              crossAxisCount: 1,
                              //crossAxisSpacing: 15,
                              mainAxisSpacing: 15.0,
                              childAspectRatio: 4.8/5,
                            ),
                            itemBuilder: (context, index) {
                              DocumentSnapshot snapshot = snapshots.data.documents[index];
                              Posting currentPosting = Posting(id: snapshot.documentID);
                              currentPosting.getPostingInfoFromSnapshot(snapshot);
                              return Stack(
                                children: <Widget>[
                                  InkResponse(
                                      enableFeedback: true,
                                      child: PostingGridTile(posting: currentPosting,),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ViewPostingsPage(posting: currentPosting,),
                                            )
                                        );
                                      }
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Container(
                                        width: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                            padding: EdgeInsets.all(0.0),
                                            //when saved posting then icon should be red heart or else black heart
                                            icon: (AppConstants.currentUser.isSavedPosting(currentPosting)) ?
                                            Icon(Icons.favorite, color: Colors.red) :
                                            Icon(Icons.favorite_border, color: Colors.black),
                                            onPressed: () {
                                              if(AppConstants.currentUser.isSavedPosting(currentPosting)) {
                                                AppConstants.currentUser.removeSavedPosting(currentPosting).whenComplete(() {
                                                  setState(() {
                                                  });
                                                });
                                              } else {
                                                AppConstants.currentUser.addSavedPosting(currentPosting).whenComplete(() {
                                                  setState(() {
                                                  });
                                                });
                                              }
                                            }
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }
                        );
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _filterModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Filters",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange
                              ),
                            ),
                            Spacer(), // will takes the width space between text and material button
                            IconButton(
                                icon: Icon(Icons.cancel, color: Colors.orange, size: 25,),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SmartSelect<String>.single(
                            title: "Type of Place",
                            value: this._houseTypeFilter,
                            isTwoLine: true,
                            options: options.houseType,
                            onChange: (val) => setState(() => this._houseTypeFilter = val),
                            modalType: SmartSelectModalType.popupDialog,
                            leading: const Icon(Icons.home),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SmartSelect<String>.single(
                            title: "Furnished apartment?",
                            value: this._furnishedFilter,
                            options: options.furnished,
                            isTwoLine: true,
                            onChange: (val) => setState(() => this._furnishedFilter = val),
                            modalType: SmartSelectModalType.popupDialog,
                            leading: const Icon(Icons.camera),
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SmartSelect<String>.single(
                            title: "Bedrooms",
                            value: this._bedroomsFilter,
                            options: options.numbers,
                            isTwoLine: true,
                            onChange: (val) => setState(() => this._bedroomsFilter = val),
                            modalType: SmartSelectModalType.popupDialog,
                            leading: const Icon(Icons.hotel),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 75),
                              child: MaterialButton(
                                color: Colors.deepOrangeAccent,
                                onPressed: () {
                                  if(_furnishedFilter != "") {
                                    _searchCategory = _furnishedFilter;
                                    _searchType = 'furnished';
                                    print(_searchCategory);
                                    print(_searchType);
                                    _searchByField();
                                  }
                                  else if(_houseTypeFilter != "") {
                                    _searchCategory = _houseTypeFilter;
                                    _searchType = 'houseType';
                                    print(_searchCategory);
                                    print(_searchType);
                                    _searchByField();
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Apply',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            Spacer(),
                            MaterialButton(
                              onPressed: () {
                                _bedroomsFilter = "";
                                _furnishedFilter = "";
                                _houseTypeFilter = "";
                                setState(() {
                                });
                              },
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        )

                      ],
                    ),
                  )
              );
            }
          );
        }
    );
  }
}