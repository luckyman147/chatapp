import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebas/CHATAPP/widgets/chat/messges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../widgets/chat/new_messgae.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final user = <String, dynamic>{"first": "Ada", "last": "dfvd", "born": 1815};

  final db = FirebaseFirestore.instance;

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen

    // Also handle any interaction when the app is in the background via a
    // Stream listener

  }


 @override
 void initState() {
    // TODO: implement initState
    super.initState();
    final fbm=FirebaseMessaging.instance;
    fbm.requestPermission();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton(
            underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Logout")
                    ],
                  ),
                  value: "logout",
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == "logout") {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
        title: Text("Chat Screen"),
      ),
      body: Container(
        child:  Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),

    );
  }
}
