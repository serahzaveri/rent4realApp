import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/reviewObjects.dart';
import 'package:househunter/Models/userObjects.dart';

class Posting {
  String id;
  String furnished;
  double price;
  String apartmentNumber;
  int streetNumber;
  String address;
  String city;
  String country;
  String zipCode;
  double rating;
  Contact host;
  String houseType;
  String personalTitle;
  String leaseStart;
  String leaseEnd;
  String flexibleDates;
  String walkingTime;
  String busTime;
  String trainTime;
  String washerDryer;

  List<String> imageNames;
  List<MemoryImage> displayImages;
  List<String> amenities;
  List<Booking> bookings;
  List<Review> reviews;
  List<User> interestedUsers;

  Map<String, int> beds;
  Map<String, int> bathrooms;

  Posting({this.id="", this.price=0, this.apartmentNumber = "",
    this.furnished="",this.streetNumber = 0, this.address="", this.city="", this.zipCode = "", this.country="", this.host,
    this.houseType="", this.personalTitle="", this.leaseStart="", this.leaseEnd="", this.flexibleDates="",
    this.walkingTime="", this.busTime="", this.trainTime="", this.washerDryer=""}) {
    this.imageNames = [];
    this.displayImages = [];
    this.amenities = [];
    this.bookings = [];
    this.reviews = [];
    this.interestedUsers = [];
    this.beds = {};
    this.bathrooms = {};
    this.rating = 0;
  }

  Future<void> getPostingInfoFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('postings').document(this.id).get();
    this.getPostingInfoFromSnapshot(snapshot);
  }

  void getPostingInfoFromSnapshot(DocumentSnapshot snapshot) {
    this.address = snapshot['address'] ?? "";
    this.amenities = List<String>.from(snapshot['amenities']) ?? [];
    this.bathrooms = Map<String, int>.from(snapshot['bathrooms']) ?? {};
    this.city = snapshot['city'] ?? "";
    this.country = snapshot['country'] ?? "";
    this.zipCode = snapshot['zip code'] ?? "";
    this.streetNumber = snapshot['street number'].toInt() ?? 0;
    this.beds = Map<String, int>.from(snapshot['beds']) ?? {};
    String hostID = snapshot['hostID'] ?? "";
    this.host = Contact(id: hostID);
    this.imageNames = List<String>.from(snapshot['imageNames']) ?? [];
    this.price = snapshot['price'].toDouble() ?? 0.0;
    this.rating = snapshot['rating'].toDouble() ?? 2.5;
    this.furnished = snapshot['furnished'] ?? "";
    this.houseType = snapshot['houseType'] ?? "";
    this.personalTitle = snapshot['personalTitle'] ?? "";
    this.leaseStart = snapshot['leaseStart'] ?? "";
    this.leaseEnd = snapshot['leaseEnd'] ?? "";
    this.flexibleDates = snapshot['flexibleDates'] ?? "";
    this.walkingTime = snapshot['walkingTime'] ?? "";
    this.busTime = snapshot['busTime'] ?? "";
    this.trainTime = snapshot['trainTime'] ?? "";
    this.washerDryer = snapshot['washerDryer'] ?? "";
  }

  Future<void> addPostingInfoToFirestore() async {
    setImageNames();
    Map<String,dynamic> data = {
      "address": this.address,
      "amenities": this.amenities,
      "bathrooms": this.bathrooms,
      "beds": this.beds,
      "city": this.city,
      "country": this.country,
      "zip code": this.zipCode,
      "hostID": AppConstants.currentUser.id,
      "imageNames": this.imageNames,
      "price": this.price,
      "rating": 2.5,
      "street number": this.streetNumber,
      "apartment number": this.apartmentNumber,
      'furnished': this.furnished,
      'houseType': this.houseType,
      'personalTitle': this.personalTitle,
      'leaseStart': this.leaseStart,
      'leaseEnd': this.leaseEnd,
      'flexibleDates': this.flexibleDates,
      'walkingTime': this.walkingTime,
      'busTime': this.busTime,
      'trainTime': this.trainTime,
      'washerDryer': this.washerDryer,
    };
    DocumentReference reference = await Firestore.instance.collection('postings').add(data);
    this.id = reference.documentID;
    await AppConstants.currentUser.addPostingToMyPostings(this);
  }

  Future<void> updatePostingInfoInFirestore() async {
    setImageNames();
    Map<String,dynamic> data = {
      "address": this.address,
      "amenities": this.amenities,
      "bathrooms": this.bathrooms,
      "beds": this.beds,
      "city": this.city,
      "country": this.country,
      "zip code": this.zipCode,
      "hostID": AppConstants.currentUser.id,
      "imageNames": this.imageNames,
      "price": this.price,
      "rating": 2.5,
      "street number": this.streetNumber,
      "apartment number": this.apartmentNumber,
      'furnished': this.furnished,
      'houseType': this.houseType,
      'personalTitle': this.personalTitle,
      'leaseStart': this.leaseStart,
      'leaseEnd': this.leaseEnd,
      'flexibleDates': this.flexibleDates,
      'walkingTime': this.walkingTime,
      'busTime': this.busTime,
      'trainTime': this.trainTime,
      'washerDryer': this.washerDryer,
    };
    await Firestore.instance.document('postings/${this.id}').updateData(data);
  }

  Future<MemoryImage> getFirstImageFromStorage() async {
    if (this.displayImages.isNotEmpty) {
      print("Display images is not empty");
      return this.displayImages.first;
    }
    print("Display images is empty");
    final String imagePath = "postingImages/${this.id}/${this.imageNames.first}";
    final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024*100);
    this.displayImages.add(MemoryImage(imageData));
    return this.displayImages.first;
  }

  Future<List<MemoryImage>> getAllImagesFromStorage() async {
    this.displayImages = [];
    for(int i = 0; i<this.imageNames.length; i++) {
      final String imagePath = "postingImages/${this.id}/${this.imageNames[i]}";
      final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024*100);
      this.displayImages.add(MemoryImage(imageData));
    }
    return this.displayImages;
  }

  void setImageNames() {
    this.imageNames = [];
    for(int i =0; i < this.displayImages.length; i++) {
      this.imageNames.add('pic$i.jpg');

    }
  }

  Future<void> addImagesToFirestore() async {
    for(int i = 0; i < this.displayImages.length; i++) {
      StorageReference reference = FirebaseStorage.instance.ref().child('postingImages/${this.id}/${this.imageNames[i]}');
      await reference.putData(this.displayImages[i].bytes).onComplete;
    }
  }

  Future<void> getHostFromFirestore() async {
    await this.host.getContactInfoFromFirestore();
    await this.host.getImageFromStorage();
  }

  // adds to saved posting when red heart icon is clicked
  Future<void> addInterestedUser(User interestedUser) async {
    this.interestedUsers.add(interestedUser);
    List<String> interested = [];
    this.interestedUsers.forEach((intUser) {
      interested.add(intUser.id);
    });
    await Firestore.instance.document('postings/${this.id}').updateData({
      'interested users': interested,
    });
  }

  Future<void> getInterestedUsersFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('postings').document(this.id).get();
    List<String> interestedUsersIDs = List<String>.from(snapshot['interested users']) ?? [];
    for(int i=0; i<interestedUsersIDs.length; i++) {
      User newUser = User(id: interestedUsersIDs[i]);
      await newUser.getUserInfoFromFirestore();
      await newUser.getImageFromStorage();
      this.interestedUsers.add(newUser);
    }
  }

  String getIsFurnished() {
    return this.furnished;
  }
  String getFullAddress() {
    return this.streetNumber.toString() + " " + this.address + ", " + this.city + ", " + this.country + "," + this.zipCode;
  }

  String getHalfAddress() {
    return this.streetNumber.toString() + " " + this.address;
  }

  String getApartmentNumber() {
    return this.apartmentNumber;
  }

  String getZipCode() {
    return this.zipCode;
  }

  List<String> getAmenitiesString() {
    return this.amenities;
  }

  String getWalkingTime() {
    return this.walkingTime;
  }

  String getBusTime() {
    return this.busTime;
  }

  String getTrainTime() {
    return this.trainTime;
  }

  String getLeaseInfo(){
    return '${this.leaseStart} - ${this.leaseEnd}';
  }

  String getBedroomText() {
    String text = "";
    if (this.beds["total"] != 0) {
      text += this.beds["total"].toString() + " Total ";
    }
    if (this.beds["available"] != 0) {
      text += this.beds["available"].toString() + " Available ";
    }
    return text;
  }

  String getBathroomText() {
    String text = "";
    if(this.bathrooms["full"] != 0) {
      text += this.bathrooms["full"].toString() + " full ";
    }
    if(this.bathrooms["half"] != 0) {
      text += this.bathrooms["half"].toString() + " half ";
    }
    return text;
  }

  Future<void> getAllBookingsFromFirestore() async {
    this.bookings = [];
    QuerySnapshot snapshots = await Firestore.instance.collection('postings/${this.id}/bookings').getDocuments();
    for (var snapshot in snapshots.documents) {
      Booking newBooking = Booking();
      await newBooking.getBookingFromFirestoreFromPosting(this, snapshot);
      this.bookings.add(newBooking);
    }
  }

  Future<void> makeNewBooking(List<DateTime> dates, BuildContext context) async {
    Map<String,dynamic> bookingData = {
      'dates': dates,
      'name': AppConstants.currentUser.getFullName(),
      'userID': AppConstants.currentUser.id,
    };
    DocumentReference reference = await Firestore.instance.collection('postings/${this.id}/bookings').add(bookingData);
    Booking newBooking = Booking();
    newBooking.createBooking(this, AppConstants.currentUser.createContactFromUser(), dates);
    newBooking.id = reference.documentID;
    this.bookings.add(newBooking);
    await AppConstants.currentUser.addBookingToFirestore(newBooking, context);
  }

  List<DateTime> getAllBookedDates() {
    List<DateTime> dates = [];
    this.bookings.forEach((booking) {
      dates.addAll(booking.dates);
    });
    return dates;
  }

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
    await Firestore.instance.collection('postings/${this.id}/reviews').add(data);
  }
}

class Booking {

  String id;
  Posting posting;
  Contact contact;
  List<DateTime> dates;

  Booking();

  void createBooking(Posting posting, Contact contact, List<DateTime> dates) {
    this.posting = posting;
    this.contact = contact;
    this.dates = dates;
    this.dates.sort();
  }

  Future<void> getBookingFromFirestoreFromUser(Contact contact, DocumentSnapshot snapshot) async {
    this.contact = contact;
    List<Timestamp> timestamps = List<Timestamp>.from(snapshot['dates']) ?? [];
    this.dates = [];
    timestamps.forEach((timestamp) {
      this.dates.add(timestamp.toDate());
    });
    String postingID = snapshot['postingID'] ?? "";
    this.posting = Posting(id: postingID);
    await this.posting.getPostingInfoFromFirestore();
    await this.posting.getFirstImageFromStorage();
  }

  Future<void> getBookingFromFirestoreFromPosting(Posting posting, DocumentSnapshot snapshot) async {
    this.posting = posting;
    List<Timestamp> timestamps = List<Timestamp>.from(snapshot['dates']) ?? [];
    this.dates = [];
    timestamps.forEach((timestamp) {
      this.dates.add(timestamp.toDate());
    });
    String contactID = snapshot['userID'] ?? "";
    String fullName = snapshot['name'] ?? "";
    _loadContactInfo(contactID, fullName);
  }

  void _loadContactInfo(String id, String fullName) {
    String firstName = "";
    String lastName = "";
    firstName = fullName.split(" ")[0];
    lastName = fullName.split(" ")[1];
    this.contact = Contact(id: id, firstName: firstName, lastName: lastName);
  }

  String getFirstDate() {
    String firstDateTime = dates.first.toIso8601String();
    return firstDateTime.substring(0, 10);
  }

  String getLastDate() {
    String lastDateTime = dates.last.toIso8601String();
    return lastDateTime.substring(0, 10);
  }
}