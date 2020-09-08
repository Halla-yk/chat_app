import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;
  final Key key;
  MessageBubble(this.message, this.isMe,this.username,{this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: isMe? MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Container(
          width: 140,
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                      topRight: Radius.circular(11),
                      topLeft: Radius.circular(11),
                      bottomLeft: isMe?Radius.circular(11): Radius.circular(0),
                      bottomRight: isMe?Radius.circular(0):Radius.circular(11)
                    )
                  ,
              color: isMe? Colors.grey[300]:Theme.of(context).accentColor),
          child:
               Column(
                crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(color: isMe? Colors.black: Colors.white, fontSize: 16),
                  ),
                  Text(

                    message,
                    style: TextStyle(color: isMe? Colors.black: Colors.white, fontSize: 17,)
                      ,textAlign: isMe? TextAlign.end:TextAlign.start,
                  ),
                ],


          ),
        ),
      ],
    );
  }
}
