import 'package:chat_app/widgets/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/newMessageTextField.dart';
class ChatScreen extends StatelessWidget {
  static const route = 'chatScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat Screen'),
          actions: [
            DropdownButton(
              icon: Icon(Icons.more_vert,color: Colors.white,),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Logout')
                      ],
                    ),
                  ),
                  value: 'Logout',
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'Logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(//ما بنفع نحط listView داخل column لذلك بنحطها داخل Expanded
                child: Messages(),

              ),
              NewMessage()
            ],
          ),
        ),
//        floatingActionButton: FloatingActionButton(
//            child: Icon(Icons.add),
//            onPressed: () {
//              FirebaseFirestore.instance
//                  .collection('chats/YpEN84fZU0DVLwrXvy1p/messages')
//                  .add({'text': 'added by button'});
//          FirebaseFirestore.instance
//              .collection('chats/YpEN84fZU0DVLwrXvy1p/messages')
//              .snapshots()
//              .listen((data) {//ال listen تعمل عمل ال stream builder
//                data.docs.forEach((doc) { print(doc.data()['text']);});
              ///////////////////////////
              //print(data.docs[0].data()['text']);//علشان يوصل لاول document في ال messages
              //اي اشي بحدثه بال firestore على طول بيتحدث هون من دون مأعمل rebuild علشان هاي stream
//            })
  );
//
//          ال snapshot بترجعلي stream بحيث كل تغير بصير بحدثلي اياه
//          ال listen بتتنفذ لكل data
  }
}
