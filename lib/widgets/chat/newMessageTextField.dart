import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = '';
  User user ;
@override
  void initState() {
  user = FirebaseAuth.instance.currentUser;
    super.initState();

  }
  void _sendMessage() async{
    Map<String,dynamic> data =await FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((value) => value.data());
    FocusScope.of(context).unfocus();
  //  print(data['username']+'kkk');
    FirebaseFirestore.instance
        .collection('chat')
        .add({'text': _enteredMessage, 'createdAt': Timestamp.now(),'userId': user.uid,'username': data['username']});
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message....'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
