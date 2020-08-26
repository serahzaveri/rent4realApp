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

  Future userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = _getData();
  }


  _getData() async {
    //gets the dates the user chose for the listing
    await AppConstants.currentUser.getDatesWithListingsFromFirestore().then((value) {
      AppConstants.currentUser.getAllBookingsFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userFuture,
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              return Text('none');
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              return Scaffold(
                  body: AppConstants.currentUser.myRRPostings.length==0 ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.priority_high, size: 100.0, color: Colors.redAccent,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('No rent resumes sent to landlord yet', style: TextStyle(fontSize: 20.0),),
                        )
                      ],
                    ),
                  ) :
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
            default:
              return Text('default');
          }
        }
    );
  }
}