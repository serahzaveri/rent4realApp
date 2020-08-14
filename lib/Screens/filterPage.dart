import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Screens/explorePage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:smart_select/smart_select.dart';
import 'package:househunter/Models/options.dart' as options;

class FilterPage extends StatefulWidget {

  static final String routeName = '/filterPageRoute';

  FilterPage({Key key}) : super(key: key);

  @override
  _FilterPageState createState() =>  _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  String _houseTypeFilter;
  String _furnishedFilter;
  String _bedroomsFilter;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: AppBarText(text: 'Filter listings'),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SmartSelect<String>.single(
                title: "Type of Place",
                value: this._houseTypeFilter,
                isTwoLine: true,
                options: options.houseType,
                onChange: (val) => setState(() => this._houseTypeFilter = val),
                modalType: SmartSelectModalType.bottomSheet,
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
                modalType: SmartSelectModalType.bottomSheet,
                leading: const Icon(Icons.hotel),
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
                modalType: SmartSelectModalType.bottomSheet,
                leading: const Icon(Icons.hotel),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 55.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExplorePage(),
                  )
                  );
                },
                child: Text(
                  "Apply",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrange
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
              ),
            )
          ],
        ),
      )
    );
  }
}