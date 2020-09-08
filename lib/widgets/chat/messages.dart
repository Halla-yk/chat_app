import 'package:chat_app/widgets/chat/messageBubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //بستخدم ال StreamBuilder لما بدي اجيب قيم متغيرة زي رسائل اما ال futureBuilder لما بدي اجيب قيمة future مرة وحدة ويفضل وضع ال streamBuilder داخل ال  futureBuilder
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final document = chatSnapshot.data.docs;
          return ListView.builder(
            reverse: true,
            itemBuilder: (ctx, index) {
              print(document[index].data()['username']+'message');
              return MessageBubble(
                document[index].data()['text'],
                document[index].data()['userId'] == user.uid,
                document[index].data()['username'],
                key: ValueKey(document[index].id),
              );
            },
            itemCount: document.length,
          );
        }
      },
    );
  }
}
