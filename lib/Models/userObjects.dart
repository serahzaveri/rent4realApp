
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/messagingObjects.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Models/reviewObjects.dart';
import 'package:househunter/Screens/conversationPage.dart';

import 'AppConstants.dart';

class Contact {
  String id;
  String firstName;
  String lastName;
  MemoryImage displayImage;

  Contact ({this.id = "", this.firstName = "", this.lastName = "", this.displayImage});

  Future<void> getContactInfoFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(this.id).get();
    this.firstName = snapshot['firstName'] ?? "";
    this.lastName = snapshot['lastName'] ?? "";
  }

  Future<MemoryImage> getImageFromStorage() async {
    if (this.displayImage != null) { return displayImage; }
    final String imagePath = "userImages/${this.id}/profile_pic.jpg";
    print('reached here');
    print(imagePath);
    final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024);
    this.displayImage = MemoryImage(imageData);
    return this.displayImage;
  }

  String getFullName() {
    return this.firstName + " " + this.lastName;
  }

  User createUserFromContact() {
    return User(
      id: this.id,
      firstName: this.firstName,
      lastName: this.lastName,
      displayImage: this.displayImage,
    );
  }

}


class User extends Contact {

  DocumentSnapshot snapshot;
  String email;
  String city;
  String country;
  bool isHost;
  bool isCurrentlyHosting;
  String password;
  String contactNumber;
  String dateOfBirth;
  String gender;
  String school;
  String program;
  String yearOfSchool;
  String homeCountry;
  String emergencyContactName;
  String emergencyContactNumber;
  String emergencyContactRelationship;
  String presentAddress;
  String presentRent;
  String presentLandlordName;
  String presentLandlordNumber;
  String priorAddress;
  String priorRent;
  String priorLandlordName;
  String priorLandlordNumber;
  int progressBar;


  List<Booking> bookings;
  List<Review> reviews;
  List<Conversation> conversations;
  List<Posting> savedPostings;
  List<Posting> myPostings;
  List<Posting> myRRPostings;
  Map<String, String> datesWithListings;

  User({String id="", String firstName = "", String lastName = "", this.email = "", MemoryImage displayImage,
    this.city = "", this.country = "", this.contactNumber="", this.dateOfBirth="", this.gender="", this.school="", this.program="",
    this.yearOfSchool="", this.homeCountry="", this.emergencyContactName="", this.emergencyContactNumber="", this.emergencyContactRelationship="",
    this.presentAddress="", this.presentRent="", this.presentLandlordName="", this.presentLandlordNumber,
    this.priorAddress="", this.priorRent="", this.priorLandlordName="", this.priorLandlordNumber="", this.progressBar=0}):
        super(id: id, firstName: firstName, lastName: lastName, displayImage: displayImage){
    this.isHost = false;
    this.isCurrentlyHosting = false;
    this.bookings = [];
    this.reviews = [];
    this.conversations = [];
    this.savedPostings = [];
    this.myPostings = [];
    this.myRRPostings = [];
    this.datesWithListings = {};
  }

  Future<void> getUserInfoFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(this.id).get();
    this.snapshot = snapshot;
    this.firstName = snapshot['firstName'] ?? "";
    this.lastName = snapshot['lastName'] ?? "";
    this.email = snapshot['email'] ?? "";
    this.city = snapshot['city'] ?? "";
    this.country = snapshot['country'] ?? "";
    this.isHost = snapshot['isHost'] ?? false;
    this.contactNumber = snapshot['contact number'] ?? "";
    this.gender = snapshot['gender'] ?? "";
    this.school = snapshot['school'] ?? "";
    this.program = snapshot['program'] ?? "";
    this.emergencyContactName = snapshot['emergency contact name'] ?? "";
    this.emergencyContactRelationship = snapshot["emergency contact relationship"] ?? "";
    this.emergencyContactNumber = snapshot['emergency contact number'] ?? "";
    this.homeCountry = snapshot['home country'] ?? "";
    this.dateOfBirth = snapshot['date of birth'] ?? "";
    this.yearOfSchool = snapshot['year of school'] ?? "";
    this.presentAddress = snapshot['present address'] ?? "";
    this.presentRent = snapshot['present rent'] ?? "";
    this.priorAddress = snapshot['prior address'] ?? "";
    this.priorRent = snapshot['prior rent'] ?? "";
    this.presentLandlordName = snapshot['present landlord name'] ?? "";
    this.presentLandlordNumber = snapshot['present landlord number'] ?? "";
    this.priorLandlordName = snapshot['prior landlord name'] ?? "";
    this.priorLandlordNumber = snapshot['prior landlord number'] ?? "";
    this.progressBar = snapshot['progressBar'] ?? 0;
    AppConstants.progressUpdate = snapshot['progressBar'] ?? 0;
  }


  Future<void> getPersonalInfoFromFirestore() async {
    await getUserInfoFromFirestore();
    await getImageFromStorage();
    await getMyPostingsFromFirestore();
    await getSavedPostingsFromFirestore();
    await getMyRRPostingsFromFirestore();
    //await getAllBookingsFromFirestore();
  }

  Future<void> getMyPostingsFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(this.id).get();
    this.myPostings = [];
    List<String> myPostingIDs = List<String>.from(snapshot['myPostingIDs']) ?? [];
    for(String postingID in myPostingIDs) {
      Posting newPosting = Posting(id: postingID);
      await newPosting.getPostingInfoFromFirestore();
      await newPosting.getAllBookingsFromFirestore();
      await newPosting.getAllImagesFromStorage();
      await newPosting.getInterestedUsersFromFirestore();
      this.myPostings.add(newPosting);
    }
  }

  List<Posting> getPostingsWithBookings() {
    List<Posting> list = [];
    for(int i=0; i<AppConstants.currentUser.myPostings.length; i++){
      if(AppConstants.currentUser.myPostings[i].bookings.length != 0) {
        list.add(AppConstants.currentUser.myPostings[i]);
        print('This posting has a booking' + AppConstants.currentUser.myPostings[i].id);
      }
    }
    return list;
  }

  List<String> getListOfMyPostings() {
    List<String> addressOfPostings = [];
    int numberOfPostings = AppConstants.currentUser.myPostings.length;
    for(int i=0; i<numberOfPostings; i++) {
      addressOfPostings.add(AppConstants.currentUser.myPostings[i].getHalfAddress());
    }
    return addressOfPostings;
  }



  Future<void> getSavedPostingsFromFirestore() async {
    List<String> savedPostingIDs = List<String>.from(snapshot['savedPostingIDs']) ?? [];
    for(int i=0; i<savedPostingIDs.length; i++) {
      Posting newPosting = Posting(id: savedPostingIDs[i]);
      await newPosting.getPostingInfoFromFirestore();
      await newPosting.getFirstImageFromStorage();
      this.savedPostings.add(newPosting);
    }
  }

  Future<void> getMyRRPostingsFromFirestore() async {
    List<String> myRRPostingIDs = List<String>.from(snapshot['myRRPostingIDs']) ?? [];
    for(String postingID in myRRPostingIDs) {
      Posting newPosting = Posting(id: postingID);
      await newPosting.getPostingInfoFromFirestore();
      await newPosting.getFirstImageFromStorage();
      this.myRRPostings.add(newPosting);
    }
  }


  Future<void> getDatesWithListingsFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(this.id).get();
    this.datesWithListings = Map<String, String>.from(snapshot.data['datesWithListings']) ?? {};
  }

  Future<void> addUserToFirestore() async {
    Map<String,dynamic> data = {
      "city": this.city,
      "country": this.country,
      "email": this.email,
      "firstName": this.firstName,
      "isHost": false,
      "lastName": this.lastName,
      "myPostingIDs": [],
      "savedPostingIDs": [],
    };
    await Firestore.instance.document('users/${this.id}').setData(data);
  }

  Future<void> addRentResumeToFirestore() async {
    Map<String,dynamic> data = {
      "contact number": this.contactNumber,
      "date of birth": this.dateOfBirth,
      "gender": this.gender,
      "school": this.school,
      "program": this.program,
      "year of school": this.yearOfSchool,
      "home country": this.homeCountry,
      "emergency contact name": this.emergencyContactName,
      "emergency contact number": this.emergencyContactNumber,
      "emergency contact relationship": this.emergencyContactRelationship,
      "present address": this.presentAddress,
      "present rent": this.presentRent,
      "present landlord name": this.presentLandlordName,
      "present landlord number": this.presentLandlordNumber,
      "prior address": this.priorAddress,
      "prior rent": this.priorRent,
      "prior landlord name": this.priorLandlordName,
      "prior landlord number": this.priorLandlordNumber,
      'progressBar': this.progressBar,
    };
    await Firestore.instance.document('users/${this.id}').updateData(data);
  }


  Future<void> updateUserInFirestore() async {
    Map<String,dynamic> data = {
      "city": this.city,
      "country": this.country,
      "firstName": this.firstName,
      "lastName": this.lastName,
    };
    await Firestore.instance.document('users/${this.id}').updateData(data);
  }

  Future<void> addImageToFirestore(File imageFile) async {
    StorageReference reference = FirebaseStorage.instance.ref().child('userImages/${this.id}/profile_pic.jpg');
    await reference.putFile(imageFile).onComplete;
    this.displayImage = MemoryImage(imageFile.readAsBytesSync());
  }

  void changeCurrentlyHosting(bool isHosting){
    this.isCurrentlyHosting = isHosting;
  }

  Future<void> becomeHost() async {
    this.isHost = true;
    Map<String,dynamic> data = {
      'isHost': true,
    };
    await Firestore.instance.document('users/${this.id}').updateData(data);
    this.changeCurrentlyHosting(true);
  }

  double getProgressBar2() {
    double doubleProgress = this.progressBar / 100;
    return doubleProgress;
  }

  Contact createContactFromUser() {
    return Contact(
      id: this.id,
      firstName: this.firstName,
      lastName: this.lastName,
      displayImage: this.displayImage,
    );
  }

  Future<void> addPostingToMyPostings(Posting posting) async {
    this.myPostings.add(posting);
    List<String> myPostingIDs = [];
    this.myPostings.forEach((posting) {
      myPostingIDs.add(posting.id);
    });
    await Firestore.instance.document('users/${this.id}').updateData({
      'myPostingIDs': myPostingIDs,
    });
  }
  /*
  Future<void> getAllBookingsFromFirestore() async {
    this.bookings = [];
    QuerySnapshot snapshots = await Firestore.instance.collection('users/${this.id}/bookings').getDocuments();
    for (var snapshot in snapshots.documents) {
      Booking newBooking = Booking();
      await newBooking.getBookingFromFirestoreFromUser(this.createContactFromUser(), snapshot);
      this.bookings.add(newBooking);
    }
  }*/

  Future<void> addBookingToFirestore(Booking booking, BuildContext context, User tenant) async {
    //we add booking data to firestore user end
    Map<String, dynamic> data = {
      'dates': booking.dates,
      'postingID': booking.posting.id,
    };
    await Firestore.instance.document('users/${tenant.id}/bookings/${booking.id}').setData(data);
    // add booking to user object list of bookings
    tenant.bookings.add(booking);
    //await addBookingConversation(booking, context);
  }

  /*Future<void> addBookingConversation(Booking booking, BuildContext context) async {
    bool result = await checkIfConversationExists(booking.posting);
    if (result) {
      continueConversationInFirestore(booking.posting, context);
    }
    else {
      Conversation conversation = Conversation();
      conversation.addOtherContact(booking.posting.host);
      await conversation.addConversationToFirestore(booking.posting.host);
      String text = "Hi, my name is ${AppConstants.currentUser
          .getFullName()}. My lease has been signed and submitted.";
      await conversation.addMessageToFirestore(text);
      //this is where i should navigate to the conversation page
      Navigator.push(
        context,
        MaterialPageRoute(builder:
            (context) => ConversationPage(conversation: conversation,),
        ),
      ).then((value) => Navigator.pop(context));
    }
  }

  Future<bool> checkIfConversationExists(Posting posting) async {
    String chatRoomID = getChatRoomId(AppConstants.currentUser.id, posting.host.id);
    DocumentSnapshot snapshot = await Firestore.instance.collection('conversations').document(chatRoomID).get();
    if (snapshot.exists) {
      print('conversation with user exists');
      return true;
    } else {
      print('conversation with user does not exist');
      return false;
    }
    /*final QuerySnapshot finalResult = await Firestore.instance.collection('conversations').where(
        'chatRoomID', isEqualTo: getChatRoomId(AppConstants.currentUser.id, posting.host.id)).limit(1).getDocuments();
    final List<DocumentSnapshot> documents = finalResult.documents;
    return (documents.length == 1);*/
  }

  Future<void> continueConversationInFirestore(Posting posting, BuildContext context) async {
    String chatRoomID = getChatRoomId(
        AppConstants.currentUser.id, posting.host.id);
    DocumentSnapshot snapshot = await Firestore.instance.collection(
        'conversations').document(chatRoomID).get();
    if (snapshot.exists) {
      Conversation currentConversation = Conversation();
      currentConversation.getConversationInfoFromFirestore(snapshot);
      //navigate to conversation
      Navigator.push(
        context,
        MaterialPageRoute(builder:
            (context) => ConversationPage(conversation: currentConversation,),
        ),
      );
    }
    else {
      print('Something wnet wrong when getting conversation');
    }
  }*/

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  /*
  List<DateTime> getAllBookedDates() {
    List<DateTime> allBookedDates = [];
    this.myPostings.forEach((posting) {
      posting.bookings.forEach((booking) {
        allBookedDates.addAll(booking.dates);
      });
    });
    return allBookedDates;
  }*/

  //this method is used to determine the heart icon on explore page
  bool isSavedPosting(Posting posting) {
    for(var savedPosting in this.savedPostings) {
      if(savedPosting.id == posting.id) {
        return true;
      }
    }
    return false;
  }

  //this method is used to determine the heart icon on explore page
  bool isMyRRPosting(Posting posting) {
    for(var myRRPosting in this.myRRPostings) {
      if(myRRPosting.id == posting.id) {
        return true;
      }
    }
    return false;
  }

  // adds to saved posting when red heart icon is clicked
  Future<void> addSavedPosting(Posting posting) async {
    for(var savedPosting in this.savedPostings) {
      if(savedPosting.id == posting.id) {
        return;
      }
    }
    this.savedPostings.add(posting);
    List<String> savedPostingIDs = [];
    this.savedPostings.forEach((savedPosting) {
      savedPostingIDs.add(savedPosting.id);
    });
    await Firestore.instance.document('users/${this.id}').updateData({
      'savedPostingIDs': savedPostingIDs,
    });
  }

  // adds to myRRpostings when rent resume is sent as well as adds it on user end array of posting id's
  Future<void> addMyRRPosting(Posting posting) async {
    //checks if already added
    for(var rentResumePosting in this.myRRPostings) {
      if(rentResumePosting.id == posting.id) {
        return;
      }
    }
    //adds if not already added to the list<Posting>
    this.myRRPostings.add(posting);
    List<String> myRRPostingIDs = [];
    this.myRRPostings.forEach((rentResumePosting) {
      myRRPostingIDs.add(rentResumePosting.id);
    });
    await Firestore.instance.document('users/${this.id}').updateData({
      'myRRPostingIDs': myRRPostingIDs,
    });
  }

  Future<void> updateDatesWithListings(String postingID, String dates) async {
    this.datesWithListings[postingID] = dates;
    await Firestore.instance.document('users/${this.id}').updateData({
      'datesWithListings': this.datesWithListings,
    });
  }

  Future<void> removeSavedPosting(Posting posting) async {
    for(int i =0; i<this.savedPostings.length; i++){
      if(this.savedPostings[i].id == posting.id) {
        this.savedPostings.removeAt(i);
        break;
      }
    }
    List<String> savedPostingIDs = [];
    this.savedPostings.forEach((savedPosting) {
      savedPostingIDs.add(savedPosting.id);
    });
    await Firestore.instance.document('users/${this.id}').updateData({
      'savedPostingIDs': savedPostingIDs,
    });
  }

  Future<void> removeMyRRPosting(Posting posting) async {
    for(int i =0; i<this.myRRPostings.length; i++){
      if(this.myRRPostings[i].id == posting.id) {
        this.myRRPostings.removeAt(i);
        break;
      }
    }
    List<String> myRRPostingIDs = [];
    this.myRRPostings.forEach((savedPosting) {
      myRRPostingIDs.add(savedPosting.id);
    });
    await Firestore.instance.document('users/${this.id}').updateData({
      'myRRPostingIDs': myRRPostingIDs,
    });
  }
  /*
  List<Booking> getPreviousTrips() {
    List<Booking> previousTrips = [];
    this.bookings.forEach((booking) {
      if(booking.dates.last.compareTo(DateTime.now()) <= 0){
        previousTrips.add(booking);
      }
    });
    return previousTrips;
  }

  List<Booking> getUpcomingTrips() {
    List<Booking> upcomingTrips = [];
    this.bookings.forEach((booking) {
      if(booking.dates.last.compareTo(DateTime.now()) > 0){
        upcomingTrips.add(booking);
      }
    });
    return upcomingTrips;
  }*/

  double getCurrentRating() {
    if(this.reviews.length == 0){ return 4; }
    double rating = 0;
    this.reviews.forEach((review){
      rating += review.rating;
    });
    rating /= this.reviews.length;
    return rating;
  }

  Future<void> postNewReview(String text, double rating) async {
    Map<String,dynamic> data = {
      'dateTime': DateTime.now(),
      'name': AppConstants.currentUser.getFullName(),
      'rating': rating,
      'text': text,
      'userID': AppConstants.currentUser.id,
    };
    await Firestore.instance.collection('users/${this.id}/reviews').add(data);
  }

}