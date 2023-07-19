
import 'package:firebas/CHATAPP/screens/auth_screen.dart';
import 'package:firebas/CHATAPP/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/chat_screen.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Chat App",
      theme: ThemeData(
        canvasColor: Colors.black54,
        hintColor: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(background: Colors.pink,
        secondary: Colors.deepPurple
        ),
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        )
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if(userSnapshot.connectionState==ConnectionState.waiting){
            return SplashScreen();
          }
          if(userSnapshot.hasData){
            return ChatScreen();
          }
          return AuthScreen();
        }
      ),
    );
  }
}
