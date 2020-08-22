import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:househunter/Screens/hostHomePage.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String path;

  PdfPreviewScreen({this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                IconButton(icon: Icon(Icons.send, color: Colors.blue), onPressed: () {
                  Navigator.pop(context);
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