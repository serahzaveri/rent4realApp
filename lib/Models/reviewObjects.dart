import 'package:flutter/cupertino.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/userObjects.dart';

class Review {
  Contact contact;
  String text;
  double rating;
  DateTime dateTime;

  Review();

  void createReview(Contact contact, String text, double rating, DateTime dateTime){
    this.contact = contact;
    this.text = text;
    this.rating = rating;
    this.dateTime = dateTime;
  }

}