import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Screens/viewPostingsPage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:househunter/Views/gridWidgets.dart';

class ExplorePage extends StatefulWidget {

  ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  //this padding is between search bar and listing
                  padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //cross Axis count tells us the number of listings we want sideways on screen
                      crossAxisCount: 1,
                      //crossAxisSpacing: 15,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 4.8/5,
                    ),
                    itemBuilder: (context, index) {
                      return InkResponse(
                        enableFeedback: true,
                        child: PostingGridTile(),
                        onTap: () {
                          Navigator.pushNamed(
                              context,
                              ViewPostingsPage.routeName,
                          );
                        }
                      );
                    }
                  ),
              ],
            ),
          ),
    );
  }
}