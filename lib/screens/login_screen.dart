import 'file:///C:/Users/hala/AndroidStudioProjects/chat_app/lib/widgets/auth/authForm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  static const route = 'AuthScreen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(
      String email, String username, String password, bool isLogin) async {
    UserCredential authResult;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print("email>>>>>>>>>"+authResult.user.email);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({'email': email, 'username':username});
      }
    } on PlatformException catch (err) {
      var message = 'ERROR';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.pinkAccent,
      ));
    } catch (err) {
      print(err.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: AuthForm(_submitAuthForm),
    );
  }
}
