import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';

// This file is used to create tiles for the explore page
//the second class is used to create tiles for the home page

class PostingGridTile extends StatefulWidget {

  final Posting posting;

  PostingGridTile({this.posting, Key key}): super(key: key);

  @override
  _PostingGridTileState createState() => _PostingGridTileState();

}

class _PostingGridTileState extends State<PostingGridTile> {

  Posting _posting;

  @override
  void initState() {
    //any changes to be made should be done here
    this._posting = widget.posting;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3/2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: this._posting.displayImages.first,
                  fit: BoxFit.fill,
              )
            ),
          ),
        ),
        AutoSizeText(
          '${_posting.type} - ${_posting.city} - ${_posting.country}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        AutoSizeText(
          _posting.name,
        style: TextStyle(
          fontSize: 16,
        ),
        ),
        Text('\$${_posting.price} / month'),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StarRating(
              size: 18.0,
              starCount: 5,
              color: AppConstants.selectedIconColor,
              borderColor: Colors.grey,
              onRatingChanged: null,
              rating: _posting.getCurrentRating(),
            ),
          ],
        )
      ],
    );
  }
}

class HomeGridTile extends StatefulWidget {
  HomeGridTile({Key key}): super(key: key);

  @override
  _HomeGridTileState createState() => _HomeGridTileState();

}

class _HomeGridTileState extends State<HomeGridTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3/2,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/apartment1.jpg'),
                  fit: BoxFit.fill,
                )
            ),
          ),
        ),
        AutoSizeText(
          'Awesome apartment',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        AutoSizeText(
          'Montreal, CA',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text('\$1000 / month'),
        Text(
          'Lease start: September 2019',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Lease end: August 2020',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

}