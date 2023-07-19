import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebas/CHATAPP/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: FirebaseFirestore.instance.collection("chat").orderBy('createdAt',descending: true).snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final documents = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (ctx, index) => MessageBubble(
              documents[index]["text"],
              documents[index]["username"],
              documents[index]["user_image"],
              documents[index]["userId"]==FirebaseAuth.instance.currentUser!.uid,
            key: ValueKey(documents[index].id),

          ),
        );
      },
    );
  }
}
