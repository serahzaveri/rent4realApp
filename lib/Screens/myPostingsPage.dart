import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Screens/createPostingPage.dart';
import 'package:househunter/Views/listWidgets.dart';

// this page is used for the host end of postings

class MyPostingsPage extends StatefulWidget {

  MyPostingsPage({Key key}) : super(key: key);

  @override
  _MyPostingsPageState createState() => _MyPostingsPageState();
}

class _MyPostingsPageState extends State<MyPostingsPage> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
            child: InkResponse(
              onTap: () {
                Navigator.pushNamed(
                    context,
                    CreatePostingPage.routeName,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: index == 2 ? CreatePostingListTile() : MyPostingListTile(),
              ),
            ),
          );
        }
      ),
    );
  }
}