import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Screens/viewPostingsPage.dart';
import 'package:househunter/Views/gridWidgets.dart';

class SavedPage extends StatefulWidget {

  SavedPage({Key key}) : super(key: key);

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {

  @override
  Widget build(BuildContext context) {
    if(AppConstants.currentUser.savedPostings.length == 0) {return Container();}
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
      child: GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: AppConstants.currentUser.savedPostings.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //cross Axis count tells us the number of listings we want sideways on screen
            crossAxisCount: 1,
            //crossAxisSpacing: 15,
            mainAxisSpacing: 15.0,
            childAspectRatio: 4.8/5,
          ),
          itemBuilder: (context, index) {
            Posting currentPosting = AppConstants.currentUser.savedPostings[index];
            return Stack(
                children: [
                  InkResponse(
                    enableFeedback: true,
                    child: PostingGridTile(posting: currentPosting,),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewPostingsPage(posting: currentPosting,),
                          )
                      );
                    }
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.all(0.0),
                            icon: Icon(Icons.clear, color: Colors.black,),
                            onPressed: () {
                            AppConstants.currentUser.removeSavedPosting(currentPosting).whenComplete(() {
                              setState(() {});
                            });
                            }
                        ),
                      ),
                    ),
                  )
                ]
            );
          }
      ),
    );
  }
}