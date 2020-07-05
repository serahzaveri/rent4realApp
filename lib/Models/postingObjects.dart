import 'package:flutter/cupertino.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/reviewObjects.dart';
import 'package:househunter/Models/userObjects.dart';

class Posting {
  String name;
  String type;
  double price;
  String description;
  String address;
  String city;
  String country;

  Contact host;

  List<String> imagePaths;
  List<AssetImage> displayImages;
  List<String> amenities;
  List<Booking> bookings;
  List<Review> reviews;

  Map<String, int> beds;
  Map<String, int> bathrooms;

  Posting({this.name="", this.type="", this.price=0, this.description="", this.address="", this.city="",
    this.country="", this.host}) {
    this.imagePaths = [];
    this.displayImages = [];
    this.amenities = [];
    this.bookings = [];
    this.reviews = [];
    this.beds = {};
    this.bathrooms = {};
  }

  int getNumGuests() {
    int numGuests = 0;
    numGuests += this.beds['small'];
    numGuests += this.beds['medium'] * 2;
    numGuests += this.beds['large'] * 2;
    return numGuests;
  }

  void setImages(List<String> imagePaths) {
    this.imagePaths = imagePaths;
    imagePaths.forEach((imagePath) {
      this.displayImages.add(AssetImage(imagePath));
    });
  }

  String getFullAddress() {
    return this.address + ", " + this.city + ", " + this.country;
  }

  String getAmenitiesString() {
    if(this.amenities.isEmpty) { return ""; }
    String amenitiesString = this.amenities.toString();
    return amenitiesString.substring(1, amenitiesString.length -1);
  }

  String getBedroomText() {
    String text = "";
    if(this.beds["small"] != 0) {
      text += this.beds["small"].toString() + " single/twin ";
    }
    if(this.beds["medium"] != 0) {
      text += this.beds["medium"].toString() + " double ";
    }
    if(this.beds["large"] != 0) {
      text += this.beds["large"].toString() + " queen/king ";
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

  void makeNewBooking(List<DateTime> dates) {
    Booking newBooking = Booking();
    newBooking.createBooking(this, AppConstants.currentUser.createContactFromUser(), dates);
    this.bookings.add(newBooking);
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

  void postNewReview(String text, double rating) {
    Review newReview = Review();
    newReview.createReview(
        AppConstants.currentUser.createContactFromUser(),
        text,
        rating,
        DateTime.now(),
    );
    this.reviews.add(newReview);
  }
}

class Booking {

  Posting posting;
  Contact contact;
  List<DateTime> dates;

  Booking();

  void createBooking(Posting posting, Contact contact, List<DateTime> dates) {
    this.posting = posting;
    this.contact = contact;
    this.dates = dates;
  }
}