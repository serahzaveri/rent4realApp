import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Models/userObjects.dart';
import 'package:househunter/Screens/payMyRent.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'PdfPreviewScreen.dart';

// this page is used for displaying the lease
class MyLeasePage extends StatefulWidget {

  MyLeasePage({Key key}) : super(key: key);

  @override
  _MyLeasePageState createState() => _MyLeasePageState();

}

class _MyLeasePageState extends State<MyLeasePage> {

  final pdf = pw.Document();

  String chosenListingID;
  Posting chosenPosting = Posting();
  String chosenUserID;
  User interestUser = User();
  bool isVisible = false;


  writeOnPdf(){
    pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(32),

          build: (pw.Context context){
            return <pw.Widget>  [
              pw.Header(
                  level: 0,
                  child: pw.Text("Lease Document")
              ),

              pw.Header(
                  level: 1,
                  child: pw.Text("General Information")
              ),

              pw.Paragraph(
                  text: "These particulars describe most of the rights and obligations of lessors and lessees. They summarize the essential points of the law concerning leases."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Header(
                  level: 1,
                  child: pw.Text("Second Heading")
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),
            ];
          },
        )
    );
  }

  Future savePdf() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
            "Send lease",
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "Step 1: Choose a listing",
                style: TextStyle(
                    fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: new DropdownButton<String>(
                    hint: Text(
                        'Select Posting',
                      style: TextStyle(
                        fontSize: 18.0
                      ),
                    ),
                    isExpanded: true, //makes the arrow at the absolute end
                    value: chosenListingID,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    items: AppConstants.currentUser.myPostings.map((Posting posting) {
                      return new DropdownMenuItem<String>(value: posting.id, child: new Text(posting.getHalfAddress()),);
                    }).toList(),
                    onChanged: (String chosenPostingID) {
                      setState(() {
                        chosenListingID = chosenPostingID;
                        chosenPosting.id = chosenListingID;
                        chosenPosting.getInterestedUsersFromFirestore().whenComplete(() {
                          setState(() {
                            isVisible = true;
                          });
                        });
                      });
                    }
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                "Step 2: Choose User",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: new DropdownButton<String>(
                      hint: Text('Select User'),
                      value: chosenUserID,
                      isExpanded: true, //makes the arrow at the absolute end
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      items: chosenPosting.interestedUsers.map((User user) {
                        return new DropdownMenuItem<String>(value: user.id, child: new Text(user.getFullName()),);
                      }).toList(),
                      onChanged: (String chosenUser) {
                        setState(() {
                          chosenUserID = chosenUser;
                          print(chosenUserID);
                          interestUser.id = chosenUser;
                          interestUser.getUserInfoFromFirestore();
                          interestUser.getDatesWithListingsFromFirestore();
                          print('User side complete');
                        });
                      }
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !isVisible,
                child: SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child: CircularProgressIndicator(),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                "Step 3: View & Send lease ",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: MaterialButton(
                onPressed: () async {
                  if(chosenListingID == null) {
                    showAlertDialog(context);
                    return ;
                  }
                  if(chosenUserID == null) {
                    showAlertDialog(context);
                    return ;
                  }
                  writeOnPdf();
                  await savePdf();
                  Directory documentDirectory = await getApplicationDocumentsDirectory();
                  String documentPath = documentDirectory.path;
                  String fullPath = "$documentPath/example.pdf";
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PdfPreviewScreen(path: fullPath, posting: chosenPosting, interestedTenant: interestUser,)
                  ));
                },
                  child: Text(
                    'View Sample Lease',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.redAccent
                    ),
                  ),
                color: Colors.amber,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayMyRent(),
                      )
                  );
                },
                child: Text(
                  'Upload your own Lease',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.redAccent
                  ),
                ),
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.

    );
  }

  //alert dialog shown to user to acknowledge that reset password email has been sent
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); //disables alert dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Details incomplete"),
      content: Text("Please choose listing and user before viewing & sending sample lease "),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }


