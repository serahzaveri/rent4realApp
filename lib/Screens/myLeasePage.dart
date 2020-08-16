import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

// this page is used for displaying the lease

class MyLeasePage extends StatefulWidget {

  MyLeasePage({Key key}) : super(key: key);

  @override
  _MyLeasePageState createState() => _MyLeasePageState();
}

class _MyLeasePageState extends State<MyLeasePage> {

  String pdfAsset = "assets/sample.pdf";
  PDFDocument _doc;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _initPDF();
  }

  _initPDF() async {
    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromAsset(pdfAsset);
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: (Text('Lease')), centerTitle: true,),
      body: _loading ? Center(child: CircularProgressIndicator(),) :
          PDFViewer(document: _doc)
    );
  }
}