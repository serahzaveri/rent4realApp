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
                  text: "These particulars describe most of the rights and obligations of lessors and lessees. They summarize the essential points of the law concerning leases, i.e. articles 1851 to 1978 of the Civil Code of Québec (C.C.Q.). The examples given in the particulars are provided for information purposes and are used to illustrate a rule. To find out the other obligations to which the parties to a lease may be subject, please refer to the Civil Code of Quebec. No right may be exercised with the intent of injuring another or in an excessive and unreasonable manner that is contrary to the requirements of good faith (arts. 6, 7 and 1375 C.C.Q.). The particulars apply to any premises leased for residential purposes, as well as to the services, accessories and dependencies attached to the dwelling, whether or not they are included in the lease of the dwelling or in another lease. Some exceptions apply (arts. 1892 and 1892.1 C.C.Q.)."
              ),

              pw.Paragraph(
                  text: "These rights and obligations shall be exercised in compliance with the rights recognized by the Charter, which prescribes, among other things, that every person has a right to respect for his or her private life, that every person has a right to the peaceful enjoyment and free disposition of his or her property, except to the extent provided by law, and that a persons home is inviolable. The Charter also prohibits any discrimination and harassment based on race, colour, sex, pregnancy, sexual orientation, civil status, age except as provided by law, religion, political convictions, language, ethnic or national origin, social condition, a handicap or the use of any means to palliate a handicap. The Charter also protects seniors and handicapped persons against any form of exploitation. Any person who is a victim of discrimination or harassment for one of those reasons may file a complaint with the Commission des droits de la personne et des droits de la jeunesse."
              ),

              pw.Header(
                  level: 1,
                  child: pw.Text("Entering into the lease")
              ),

              pw.Paragraph(
                  text: "A lease is not terminated by the death of the lessor or the lessee (art. 1884 C.C.Q.). A person who was living with the lessee at the time of the lessees death may become the lessee if he or she continues to occupy the dwelling and gives notice to that effect in writing to the lessor within two months after the death. Otherwise, the liquidator of the succession or, if there is no liquidator, an heir may, in the month that follows the expiry of the two-month period, terminate the lease by giving notice of one month to that effect to the lessor. If no one was living with the lessee at the time of his or her death, the liquidator of the succession or, if there is no liquidator, an heir may resiliate the lease by giving the essor two months notice within six months after the death. The resiliation takes effect before the two-month period expires if the liquidator or the heir and the lessor so agree or when the dwelling is re-leased by the lessor during that same period."
              ),

              pw.Paragraph(
                  text: "Non-payment of rent entitles the lessor to apply to the tribunal for a condemnation forcing the lessee to pay it. Also, if the lessee is over three weeks late in paying the rent, the lessor may obtain the resiliation of the lease and the eviction of the lessee. Frequent late payment of the rent may also warrant the resiliation of the lease if the lessor suffers serious prejudice as a result (arts. 1863 and 1971 C.C.Q.)"
              ),

              pw.Paragraph(
                  text: "A married or civil union spouse who rents adwelling for the current needs of the family also binds the other spouse for the whole, if they are not separated from bed and board, unless the other spouse has previously informed the lessor of his or her unwillingness to be bound for the debt (arts. 397 and 521.6 C.C.Q.)."
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
                          interestUser.id = chosenUser;
                          interestUser.getUserInfoFromFirestore();
                          interestUser.getDatesWithListingsFromFirestore();
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


