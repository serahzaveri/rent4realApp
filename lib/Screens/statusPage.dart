import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Views/listWidgets.dart';

class StatusPage extends StatefulWidget {

  StatusPage({Key key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppConstants.currentUser.myRRPostings.length==0 ? Container(child: Text('No rent resumes sent to landlord yet', style: TextStyle(fontSize: 22.0),),) :
      ListView.builder(
        itemCount: AppConstants.currentUser.myRRPostings.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 15.0),
              child: StatusListTile(
                posting: AppConstants.currentUser.myRRPostings[index],
              ),
            ),
          );
        },
      )
    );
  }
}