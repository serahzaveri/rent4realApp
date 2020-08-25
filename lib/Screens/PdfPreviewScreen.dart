import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Models/userObjects.dart';
import 'package:househunter/Screens/hostHomePage.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String path;
  final Posting posting;
  final User interestedTenant;

  PdfPreviewScreen({this.path, this.posting, this.interestedTenant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          PDFViewerScaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: (){
                    Navigator.pop(context);
                  }
              ),
              title: Text(
                'Sample Lease',
                  style: TextStyle(
                    color: Colors.black,
                  )
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                //send button for lease results in navigation to bookings page
                IconButton(icon: Icon(Icons.send, color: Colors.blue), onPressed: () {
                  String dates = interestedTenant.datesWithListings[posting.id];
                  print('The dates are' + dates);
                  posting.makeNewBooking(interestedTenant.datesWithListings[posting.id], interestedTenant, context);
                  print('Booking Complete');
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HostHomePage(index: 0,)));
                })
              ],
            ),
            path: path,
          ),
        ],
      ),
    );
  }
}