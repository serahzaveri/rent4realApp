import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
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
        itemCount: AppConstants.currentUser.myPostings.length + 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
            child: InkResponse(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePostingPage(
                        posting: (index == AppConstants.currentUser.myPostings.length) ?
                        null :
                        AppConstants.currentUser.myPostings[index],
                      ),
                    ),
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
                child: index == AppConstants.currentUser.myPostings.length ?
                CreatePostingListTile() :
                MyPostingListTile(posting: AppConstants.currentUser.myPostings[index],),
              ),
            ),
          );
        }
      ),
    );
  }
}