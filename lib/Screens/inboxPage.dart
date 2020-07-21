import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/messagingObjects.dart';
import 'package:househunter/Screens/conversationPage.dart';
import 'package:househunter/Views/TextWidgets.dart';
import 'package:househunter/Views/listWidgets.dart';
import 'conversationPage.dart';

class InboxPage extends StatefulWidget {

  InboxPage({Key key}) : super(key: key);

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: StreamBuilder(
        stream: Firestore.instance.collection('conversations').where(
            'userIDs', arrayContains: AppConstants.currentUser.id).snapshots(),
        builder: (context, snapshots) {
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                  itemCount: snapshots.data.documents.length,
                  itemExtent: MediaQuery.of(context).size.height / 7,
                  itemBuilder: (context, index) {
                    DocumentSnapshot snapshot = snapshots.data.documents[index];
                    Conversation currentConversation = Conversation();
                    currentConversation.getConversationInfoFromFirestore(snapshot);
                    return InkResponse(
                      child: ConversationListTile(conversation: currentConversation,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder:
                              (context) => ConversationPage(conversation: currentConversation,),
                          ),
                        );
                      },
                    );
                  }
              );
          }
        },
      ),
    );
  }
}