import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/messagingObjects.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Models/reviewObjects.dart';
import 'package:househunter/Models/userObjects.dart';
import 'package:househunter/Screens/viewPostingsPage.dart';
import 'package:househunter/Screens/viewProfilePage.dart';

class ReviewListTile extends StatefulWidget{

  final Review review;

  ReviewListTile({this.review, Key key}): super(key: key);

  @override
  _ReviewListTileState createState() => _ReviewListTileState();

}

class _ReviewListTileState extends State<ReviewListTile> {

  Review _review;

  @override
  void initState() {
    this._review = widget.review;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            InkResponse(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewProfilePage(contact: _review.contact),
                    )
                );
              },
              child: Container(
                child: (_review.contact.displayImage == null) ? Container(
                  width: MediaQuery.of(context).size.width / 7.5,
                ) : CircleAvatar(
                  backgroundImage: _review.contact.displayImage,
                  radius: MediaQuery.of(context).size.width / 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: AutoSizeText(
                _review.contact.firstName,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StarRating(
              size: 25.0,
              starCount: 5,
              color: AppConstants.selectedIconColor,
              borderColor: Colors.grey,
              onRatingChanged: null,
              rating: _review.rating,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
          child: AutoSizeText(
            _review.text,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }
}

class ConversationListTile extends StatefulWidget {

  final Conversation conversation;

  ConversationListTile({this.conversation, Key key}): super(key: key);

  @override
  _ConversationListTileState createState() => _ConversationListTileState();

}

class _ConversationListTileState extends State<ConversationListTile> {

  Conversation _conversation;

  @override
  void initState() {
    this._conversation = widget.conversation;
    this._conversation.otherContact.getImageFromStorage().whenComplete(() {setState(() {

    });});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewProfilePage(contact: _conversation.otherContact,),
              )
          );
        },
        child: CircleAvatar(
          backgroundImage: _conversation.otherContact.displayImage,
          radius: MediaQuery.of(context).size.width / 14.0,
        ),
      ),
      title: Text(
        _conversation.otherContact.getFullName(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.5,
        ),
      ),
      subtitle: AutoSizeText(
        //_conversation.getLastMessageText(),
        _conversation.lastMessage.text,
        minFontSize: 20.0,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        //_conversation.getLastMessageDateTime(),
        _conversation.lastMessage.getMessageDateTime(),
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
    );
  }

}

class MessageListTile extends StatelessWidget {

  final Message message;

  MessageListTile({this.message, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.sender.firstName == AppConstants.currentUser.firstName) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(35, 15, 15, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textWidthBasis: TextWidthBasis.parent,
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            message.getMessageDateTime(),
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                /*
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewProfilePage(contact: AppConstants.currentUser.createContactFromUser(),),
                    )
                );*/
              },
              child: CircleAvatar(
                backgroundImage: AppConstants.currentUser.displayImage,
                radius: MediaQuery.of(context).size.width / 20,
              ),
            ),
          ],
        ),
      );
    }
    else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 35, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewProfilePage(contact: message.sender,),
                    )
                );
              },
              child: CircleAvatar(
                backgroundImage: message.sender.displayImage,
                radius: MediaQuery.of(context).size.width / 20,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textWidthBasis: TextWidthBasis.parent,
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            message.getMessageDateTime(),
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}



class MyPostingListTile extends StatefulWidget {

  final Posting posting;

  MyPostingListTile({this.posting, Key key}): super(key: key);

  @override
  _MyPostingListTileState createState() => _MyPostingListTileState();

}

class _MyPostingListTileState extends State<MyPostingListTile> {

  Posting _posting;

  @override
  void initState() {
    this._posting = widget.posting;
    for(int i=0; i<this._posting.interestedUsers.length; i++){
      this._posting.interestedUsers[i].getUserInfoFromFirestore().whenComplete(() {
        this._posting.interestedUsers[i].getImageFromStorage().whenComplete(() {
          this._posting.interestedUsers[i].getDatesWithListingsFromFirestore().whenComplete(() {
            print('Got this users diplay image');
            setState(() {});
          });
        }
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
          leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: <Widget>[
                  AutoSizeText(
                    _posting.getHalfAddress() ?? "",
                    maxLines: 2,
                    minFontSize: 20.0,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
          ),
          trailing: AspectRatio(
            aspectRatio: 3/2,
            child: Image(
              image: _posting.displayImages.first,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: Text(
            'Interested users',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _posting.interestedUsers.length == 0 ? Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
            child: Text(
              'No interested users yet',
            style: TextStyle(
              fontSize: 14.0,
            ),),
          ),
        ) : ListView.builder(
          itemCount: _posting.interestedUsers.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewProfilePage(contact: _posting.interestedUsers[index].createContactFromUser(),),
                  )
              ),
              leading: CircleAvatar(backgroundImage: _posting.interestedUsers[index].displayImage,),
              title: Text(_posting.interestedUsers[index].getFullName()),
              subtitle: Text('Dates: ${_posting.interestedUsers[index].datesWithListings[_posting.id]}'),
            );
          },
        )
      ],
    );
  }
}

class StatusListTile extends StatefulWidget {

  final Posting posting;
  final Booking booking;

  StatusListTile({this.posting, this.booking, Key key}): super(key: key);

  @override
  _StatusListTileState createState() => _StatusListTileState();

}

class _StatusListTileState extends State<StatusListTile> {

  Booking _booking;
  Posting _posting;

  @override
  void initState() {
    this._posting = widget.posting;
    this._booking = widget.booking;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String key = "";
    if( AppConstants.currentUser.datesWithListings[_posting.id] != null) {
      key = AppConstants.currentUser.datesWithListings[_posting.id];
    }
    else{
      key = 'Not initialized';
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPostingsPage(posting: _posting,)));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.deepOrangeAccent,
              width: 2.0
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Row(
                  children: <Widget>[
                      Text(
                        _posting.getHalfAddress(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Spacer(),
                   Text(
                     'Go to Listing',
                     style: TextStyle(
                       fontSize: 16.0,
                     ),
                   ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                      "Dates: ",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                  Text(
                      key,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('RentResume Status: '),
                  IconButton(icon: Icon(Icons.check_circle),),
                ],
              ),
              this._booking == null ? Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Lease status: ',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'Waiting for landlord',
                        style: TextStyle(
                            color: Colors.red
                        ),
                      ),
                      IconButton(icon: Icon(Icons.blur_circular),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Completed',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      IconButton(icon: Icon(Icons.blur_circular),),
                    ],
                  ),
                ],
              ) : this._booking.posting.id == _posting.id ? Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Lease status: ',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'Signed',
                        style: TextStyle(
                            color: Colors.red
                        ),
                      ),
                      IconButton(icon: Icon(Icons.check_circle),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Completed',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      IconButton(icon: Icon(Icons.check_circle),),
                    ],
                  ),
                ],
              ) : Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Waiting for landlord',
                        style: TextStyle(
                            color: Colors.red
                        ),
                      ),
                      IconButton(icon: Icon(Icons.blur_circular),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Completed',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      IconButton(icon: Icon(Icons.blur_circular),),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CreatePostingListTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.deepOrangeAccent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.add),
          ),
          Text(
            'Create a posting',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0
            ),
          )
        ],
      )
    );
  }

}

class BookingsListTile extends StatefulWidget {

  final Posting posting;

  BookingsListTile({this.posting, Key key}): super(key: key);

  @override
  _BookingsListTileState createState() => _BookingsListTileState();

}

class _BookingsListTileState extends State<BookingsListTile> {

  Posting _posting;

  @override
  void initState() {
    this._posting = widget.posting;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
        color: Colors.deepOrangeAccent,
        width: 2.0
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
            leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  children: <Widget>[
                    AutoSizeText(
                      _posting.getHalfAddress() ?? "",
                      maxLines: 2,
                      minFontSize: 20.0,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                )
            ),
            trailing: AspectRatio(
              aspectRatio: 3/2,
              child: Image(
                image: _posting.displayImages.first,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
              child: Text(
                'Tenant: ${_posting.bookings[0].user.getFullName()}',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
              child: Text(
                'Tenant email ID: ${_posting.bookings[0].user.email}',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
              child: Text(
                'Lease start date: ${_posting.bookings[0].getFirstDate()}',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
              child: Text(
                'Lease end date: ${_posting.bookings[0].getLastDate()}',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
