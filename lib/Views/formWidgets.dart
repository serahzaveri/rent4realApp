
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:househunter/Models/AppConstants.dart';

class ReviewForm extends StatefulWidget {

  ReviewForm({Key key}): super(key: key);
  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Review Text',
                      ),
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: StarRating(
                        rating: 2.5,
                        size: 40.0,
                        starCount: 5,
                        color: AppConstants.selectedIconColor,
                        borderColor: Colors.grey,
                        onRatingChanged: (rating) {},
                      ),
                    ),
                  ],
            )
            ),
            MaterialButton(
              onPressed: () {},
              child: Text('Submit'),
              color: Colors.blue,
                )
          ],
        ),
      ),
    );
  }

}