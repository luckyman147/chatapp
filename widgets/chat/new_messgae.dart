import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enterMessage = "";

_sendMessage()async{
  FocusScope.of(context).unfocus();
    // Add a new document with a generated ID
final user= FirebaseAuth.instance.currentUser;
final userData=await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
        FirebaseFirestore.instance.collection("chat")
        .add({
          "text":_enterMessage,
          "createdAt":Timestamp.now(),
          'username':userData['username'],
          'userId':user.uid,
          'user_image':userData['image_url'],

        });

  _controller.clear();
  setState(() {
    _enterMessage="";
  });
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
                autocorrect: true,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(color: Colors.white),
                cursorColor: Theme.of(context).primaryColor,
                controller: _controller,

            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)
                ),

                hintText: "Send a message...",
                hintStyle: TextStyle(color: Theme.of(context).primaryColor)

            ),
            onChanged: (value) {
              setState(() {
                _enterMessage = value;
              });
            },
          )),
          IconButton(

              color: Theme.of(context).primaryColor,
              disabledColor: Colors.white,
              onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage,
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
