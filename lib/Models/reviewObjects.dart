import 'package:cloud_firestore/cloud_firestore.dart';
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

  void getReviewInfoFromFirestore(DocumentSnapshot snapshot) {
    this.rating = snapshot['rating'].toDouble() ?? 3.0;
    this.text = snapshot['text'] ?? "";
    Timestamp timeStamp = snapshot['dateTime'] ?? Timestamp.now();
    this.dateTime = timeStamp.toDate();
    String fullName = snapshot['name'] ?? "";
    String contactID = snapshot['userID'] ?? "";
    _loadContactInfo(contactID, fullName);
  }

  void _loadContactInfo(String id, String fullName) {
    String firstName = "";
    String lastName = "";
    firstName = fullName.split(" ")[0];
    lastName = fullName.split(" ")[1];
    this.contact = Contact(id: id, firstName: firstName, lastName: lastName);
  }

}