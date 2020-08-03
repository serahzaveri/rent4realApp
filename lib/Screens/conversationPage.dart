import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/messagingObjects.dart';
import 'package:househunter/Screens/guestHomePage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:househunter/Views/listWidgets.dart';

class ConversationPage extends StatefulWidget {
  //check for changes here

  final Conversation conversation;

  static final String routeName = '/conversationPageRoute';

  ConversationPage({this.conversation, Key key}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {

  Conversation _conversation;
  TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    String text = _controller.text;
    if(text.isEmpty) {return;}
    this._conversation.addMessageToFirestore(text).whenComplete(() {
      setState(() {
        _controller.text = "";
      });
    });

  }

  @override
  void initState() {
    this._conversation = widget.conversation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppBarText(text: _conversation.otherContact.getFullName())
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance.collection('conversations/${this._conversation.id}/messages').orderBy('dateTime').snapshots(),
              builder: (context, snapshots) {
                switch (snapshots.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return ListView.builder(
                      itemCount: snapshots.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot snapshot = snapshots.data.documents[index];
                        Message currentMessage = Message();
                        currentMessage.getMessageInfoFromFirestore(snapshot);
                        if (currentMessage.sender.id == AppConstants.currentUser.id) {
                          currentMessage.sender = AppConstants.currentUser.createContactFromUser();
                        } else {
                          currentMessage.sender = this._conversation.otherContact;
                        }
                        return MessageListTile(message: currentMessage,);
                      },
                    );
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              )
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 5/6,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Write a message',
                      contentPadding: EdgeInsets.all(20.0),
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: 5,
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                    controller: _controller,
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: _sendMessage,
                    child: Text('Send'),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
