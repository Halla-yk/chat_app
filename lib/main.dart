import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.teal,
            backgroundColor: Colors.teal,
            accentColor: Colors.pinkAccent,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context)
                .copyWith(buttonColor: Colors.pinkAccent,
                textTheme: ButtonTextTheme.primary
                ,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        routes: {
          ChatScreen.route: (context) => ChatScreen(),
          AuthScreen.route: (context) => AuthScreen()
        },

        home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,userSnapshot){
             if(userSnapshot.hasData){//يعني يوجد token
               return ChatScreen();
             }else{
               return AuthScreen();
             }
          },)
    );
  }
}
