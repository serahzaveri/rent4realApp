import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/reviewObjects.dart';
import 'package:househunter/Models/userObjects.dart';

class Posting {
  String id;
  String name;
  String type;
  double price;
  String description;
  double streetNumber;
  String address;
  String city;
  String country;
  String zipCode;
  double rating;

  Contact host;

  List<String> imageNames;
  List<MemoryImage> displayImages;
  List<String> amenities;
  List<Booking> bookings;
  List<Review> reviews;

  int bedrooms;

  Map<String, int> bathrooms;

  Posting({this.id="", this.name="", this.type="", this.price=0, this.description="", this.streetNumber = 0, this.address="",
    this.city="", this.zipCode = "", this.country="", this.host, this.bedrooms=0}) {
    this.imageNames = [];
    this.displayImages = [];
    this.amenities = [];
    this.bookings = [];
    this.reviews = [];
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
    this.description = snapshot['description'] ?? "";
    this.zipCode = snapshot['zip code'] ?? "";
    this.streetNumber = snapshot['street number'].toDouble() ?? 0.0;
    this.bedrooms = snapshot['bedrooms'].toInt() ?? 0;

    String hostID = snapshot['hostID'] ?? "";
    this.host = Contact(id: hostID);

    this.imageNames = List<String>.from(snapshot['imageNames']) ?? [];
    this.name = snapshot['name'] ?? "";
    this.price = snapshot['price'].toDouble() ?? 0.0;
    this.rating = snapshot['rating'].toDouble() ?? 2.5;
    this.type = snapshot['type'] ?? "";
  }

  Future<void> addPostingInfoToFirestore() async {
    setImageNames();
    Map<String,dynamic> data = {
      "address": this.address,
      "amenities": this.amenities,
      "bathrooms": this.bathrooms,
      "bedrooms": this.bedrooms.toInt(),
      "city": this.city,
      "country": this.country,
      "zip code": this.zipCode,
      "description": this.description,
      "hostID": AppConstants.currentUser.id,
      "imageNames": this.imageNames,
      "name": this.name,
      "price": this.price,
      "rating": 2.5,
      "street number": this.streetNumber,
      "type": this.type,
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
      "bedrooms": this.bedrooms,
      "city": this.city,
      "country": this.country,
      "zip code": this.zipCode,
      "description": this.description,
      "hostID": AppConstants.currentUser.id,
      "imageNames": this.imageNames,
      "name": this.name,
      "price": this.price,
      "rating": this.rating,
      "street number": this.streetNumber,
      "type": this.type,
    };
    await Firestore.instance.document('postings/${this.id}').updateData(data);
  }

  Future<MemoryImage> getFirstImageFromStorage() async {
    if (this.displayImages.isNotEmpty) { return this.displayImages.first; }
    final String imagePath = "postingImages/${this.id}/${this.imageNames.first}";
    final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024*60);
    this.displayImages.add(MemoryImage(imageData));
    return this.displayImages.first;
  }

  Future<List<MemoryImage>> getAllImagesFromStorage() async {
    this.displayImages = [];
    for(int i = 0; i<this.imageNames.length; i++) {
      final String imagePath = "postingImages/${this.id}/${this.imageNames[i]}";
      final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024*5);
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

  String getFullAddress() {
    return this.streetNumber.toString() + this.address + ", " + this.city + ", " + this.country + "," + this.zipCode;
  }

  String getZipCode() {
    return this.zipCode;
  }

  int getNumBedrooms() {
    return this.bedrooms;
  }

  String getAmenitiesString() {
    if(this.amenities.isEmpty) { return ""; }
    String amenitiesString = this.amenities.toString();
    return amenitiesString.substring(1, amenitiesString.length -1);
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

  Future<void> makeNewBooking(List<DateTime> dates) async {
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
    await AppConstants.currentUser.addBookingToFirestore(newBooking);
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