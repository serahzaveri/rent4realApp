import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'PdfPreviewScreen.dart';

// this page is used for displaying the lease
class MyLeasePage extends StatelessWidget {

  MyLeasePage({Key key}) : super(key: key);

  final pdf = pw.Document();
  String chosenListing;

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
        title: Text("Lease"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Choose a listing", style: TextStyle(fontSize: 30),),
            new DropdownButton(
                hint: Text('Select listing'),
                value: chosenListing,
                items: AppConstants.currentUser.getListOfMyPostings().map((String value) {
                  return new DropdownMenuItem<String>(value: value, child: new Text(value),);
                }).toList(),
                onChanged: (_) {}
                ),
            //Text("Choose user to send lease", style: TextStyle(fontSize: 30),),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 80.0, 30.0, 20.0),
              child: MaterialButton(
                onPressed: () async {
                  writeOnPdf();
                  await savePdf();
                  Directory documentDirectory = await getApplicationDocumentsDirectory();
                  String documentPath = documentDirectory.path;
                  String fullPath = "$documentPath/example.pdf";
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PdfPreviewScreen(path: fullPath,)
                  ));
                },
                  child: Text(
                    'Use Sample Lease',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.redAccent
                    ),
                  ),
                color: Colors.amber,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
              child: MaterialButton(
                onPressed: () {},
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
  }

