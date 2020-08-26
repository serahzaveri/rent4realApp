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
    this._posting = widget.posting;
    this._posting.getFirstImageFromStorage().whenComplete(() {
      setState(() {});
    });
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
          child: (this._posting.displayImages.isEmpty) ? Container() : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: this._posting.displayImages.first,
                  fit: BoxFit.fill,
              )
            ),
          ),
        ),
        AutoSizeText(
          '${_posting.streetNumber} ${_posting.address}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        AutoSizeText(
          _posting.getLeaseInfo(),
        style: TextStyle(
          fontSize: 13,
        ),
        ),
        _posting.houseType == "Entire Apartment" ? Text(
          '${_posting.houseType} -- ${_posting.beds['total']} bedrooms',
          style: TextStyle(
            fontSize: 13,
          ),
        ) :
        Text(
          '${_posting.beds['available']} of ${_posting.beds['available']} bedrooms available',
          style: TextStyle(
            fontSize: 13,
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

  final Booking booking;

  HomeGridTile({this.booking, Key key}): super(key: key);

  @override
  _HomeGridTileState createState() => _HomeGridTileState();

}

class _HomeGridTileState extends State<HomeGridTile> {

  Booking _booking;

  @override
  void initState() {
    this._booking = widget.booking;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3.5/2,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: _booking.posting.displayImages.first,
                  fit: BoxFit.fill,
                )
            ),
          ),
        ),
        AutoSizeText(
          '${_booking.posting.city} ${_booking.posting.country}',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text('\$${_booking.posting.price} / month'),
        Text(
          'Lease start: ${_booking.getFirstDate()}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Lease end: ${_booking.getLastDate()}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

}