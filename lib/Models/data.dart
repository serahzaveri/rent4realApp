
import 'package:househunter/Models/messagingObjects.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Models/reviewObjects.dart';
import 'package:househunter/Models/userObjects.dart';
/*
class PracticeData {
  static List<User> users = [];
  static List<Posting> postings =[];

  static populateFields() {

    User user1 = User(
      firstName: "Alisha",
      lastName: "Zaveri",
      email: "shalmypal@gmail.com",
      bio: "Living the life and killing it!!",
      city: "Champaign",
      country: "USA"
    );
    user1.isHost = true;

    User user2 = User(
      firstName: "Serah",
      lastName: "Zaveri",
      email: "serah.zaveri@mail.mcgill.ca",
      bio: "Building my first vey app. Student at McGill University",
      city: "Montreal",
      country: "Canada"
    );

    users.add(user1);
    users.add(user2);

    Review review = Review();
    review.createReview(
        user2.createContactFromUser(),
        "Fun gal Enjoyed living here",
        4,
        DateTime.now()
    );
    user1.reviews.add(review);

    Conversation conversation = Conversation();
    conversation.createConversation(user2.createContactFromUser(), []);

    Message message1 = Message();
    message1.createMessage(
        user1.createContactFromUser(),
        'Serah is the best',
        DateTime.now()
    );

    Message message2 = Message();
    message2.createMessage(
        user2.createContactFromUser(),
        'I know right! I am so happy she is in my life',
        DateTime.now()
    );

    conversation.messages.add(message1);
    conversation.messages.add(message2);

    user1.conversations.add(conversation);

    Posting posting1 = Posting(
      name: "Shalaka's house",
      type: 'Apartment',
      price: 1200,
      description: 'Has a jacuzzi',
      address: "123 avenue",
      city: 'Champaign',
      country: 'USA',
      host: user1.createContactFromUser(),
    );
    //posting1.setImages(['assets/images/apartment1.jpg']);
    posting1.amenities = ['washer', 'dryer'];
    posting1.bathrooms = {
      'full': 2,
      'half': 0,
    };

    Posting posting2 = Posting(
      name: "Alisha's apartment",
      type: "Apartment",
      price: 1000,
      description: "Modern and chic, central location, convenient and close to everything",
      address: "111 West Broadway",
      city: "NYC",
      country: "USA",
      host: user2.createContactFromUser(),
    );
    //posting2.setImages(['assets/images/apartment2.jpg']);
    posting2.amenities = ['dishwasher', 'Cable', 'WiFi'];
    posting2.beds = {
      'small': 1,
      'medium': 0,
      'large': 1,
    };
    posting2.bathrooms = {
      'full': 1,
      'half': 1,
    };

    postings.add(posting1);
    postings.add(posting2);

    Booking booking1 = Booking();
    booking1.createBooking(
      posting2,
      user1.createContactFromUser(),
      [DateTime(2020, 08, 20),DateTime(2020, 08, 21),DateTime(2020, 08, 22),],
    );
    Booking booking2 = Booking();
    booking2.createBooking(
      posting1,
      user1.createContactFromUser(),
      [DateTime(2020, 06, 10),DateTime(2020, 06, 11),],
    );
    posting2.bookings.add(booking1);
    posting2.bookings.add(booking2);

    Review postingReview = Review();
    postingReview.createReview(
      user2.createContactFromUser(),
      "Pretty decent place, not as big as I was expecting though",
      3.5,
      DateTime(2019, 08, 08),
    );
    posting1.reviews.add(postingReview);

    user1.bookings.add(booking1);
    user1.bookings.add(booking2);
    user1.myPostings.add(posting1);
    user2.myPostings.add(posting2);
    user1.savedPostings.add(posting2);
  }



}*/