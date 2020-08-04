
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/postingObjects.dart';
import 'package:househunter/Models/userObjects.dart';

class Conversation{

  String id;
  Contact otherContact;
  List<Message> messages;
  Message lastMessage;

  Conversation() {
    messages = [];
  }

  void createConversation(Contact otherContact, List<Message> messages) {
    this.otherContact = otherContact;
    this.messages = messages;
    if(messages.isNotEmpty) {
      this.lastMessage = messages.last;
    }
  }

  void addOtherContact(Contact otherContact) {
    this.otherContact = otherContact;
  }

  void getConversationInfoFromFirestore(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    String lastMessageText = snapshot['lastMessageText'] ?? "";
    Timestamp lastMessageTimeStamp = snapshot['lastMessageDateTime'] ?? Timestamp.now();
    DateTime lastMessageDateTime = lastMessageTimeStamp.toDate();
    this.lastMessage = Message();
    this.lastMessage.dateTime = lastMessageDateTime;
    this.lastMessage.text = lastMessageText;
    List<String> userIDs = List<String>.from(snapshot['userIDs']) ?? [];
    List<String> userNames = List<String>.from(snapshot['userNames']) ?? [];
    this.otherContact = Contact();
    for(String userID in userIDs) {
      if (userID != AppConstants.currentUser.id) {
        this.otherContact.id = userID;
        break;
      }
    }
    for(String name in userNames) {
      if (name != AppConstants.currentUser.getFullName()) {
        this.otherContact.firstName = name.split(" ")[0];
        this.otherContact.lastName = name.split(" ")[1];
        break;
      }
    }
  }

  Future<void> addConversationToFirestore(Contact otherContact) async {
    List<String> userNames = [
      AppConstants.currentUser.getFullName(),
      otherContact.getFullName(),
    ];
    List<String> userIDs = [
      AppConstants.currentUser.id,
      otherContact.id,
    ];
    String chatID = getChatRoomId(AppConstants.currentUser.id, otherContact.id);
    Map<String,dynamic> convoData = {
      'lastMessageDateTime': DateTime.now(),
      'lastMessageText': "",
      'userNames': userNames,
      'userIDs': userIDs,
      'chatRoomID': chatID,
    };
    //the reference id will be the chat room id
    DocumentReference reference = await Firestore.instance.document('conversations/$chatID');
    reference.setData(convoData);
    this.id = chatID;
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Future<void> addMessageToFirestore(String messageText) async {
    DateTime now = DateTime.now();
    Map<String,dynamic> messageData = {
      'dateTime': now,
      'senderID': AppConstants.currentUser.id,
      'text': messageText
    };
    await Firestore.instance.collection('conversations/${this.id}/messages').add(messageData);
    Map<String,dynamic> convoData = {
      'lastMessageDateTime': now,
      'lastMessageText': messageText
    };
    await Firestore.instance.document('conversations/${this.id}').updateData(convoData);
  }

}


class Message {

  Contact sender;
  String text;
  DateTime dateTime;

  Message();

  void createMessage(Contact sender, String text, DateTime dateTime) {
    this.sender = sender;
    this.text = text;
    this.dateTime = dateTime;
  }

  void getMessageInfoFromFirestore(DocumentSnapshot snapshot) {
    Timestamp lastMessageTimeStamp = snapshot['dateTime'] ?? Timestamp.now();
    this.dateTime = lastMessageTimeStamp.toDate();
    String senderID = snapshot['senderID'] ?? "";
    this.sender = Contact(id: senderID);
    this.text = snapshot['text'] ?? "";

  }

  String getMessageDateTime(){
    final DateTime now = DateTime.now();
    final int today = now.day;
    if(this.dateTime.day == today){
      return _getTime();
    } else {
      return _getDate();
    }
  }

  String _getTime() {
    String time = dateTime.toIso8601String().substring(11, 16);
    String hours = time.substring(0, 2);
    int hoursInt = int.parse(hours);
    if (hoursInt > 12) {hoursInt -= 12;}
    hours = hoursInt.toString();
    String minutes = time.substring(2);
    return hours + minutes;
  }

  String _getDate(){
    String date = dateTime.toIso8601String().substring(5, 10);
    String month = date.substring(0, 2);
    int monthInt = int.parse(month);
    String monthName = AppConstants.monthDict[monthInt];
    String day = date.substring(3, 5);
    return monthName + "/" + day;
  }
}