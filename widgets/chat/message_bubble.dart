import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

   MessageBubble( this.message,this.Username, this.UserImage,this.isMe,{ required this.key});
final Key key;
final String  message;
final bool isMe;
final String Username;
final String UserImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
clipBehavior: Clip.none,
      children:[
       Row(
        mainAxisAlignment:  isMe? MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isMe? Colors.grey[300]:Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe? Radius.circular(0):Radius.circular(12),
                bottomRight: isMe? Radius.circular(0):Radius.circular(12),
              ),
            ),
            width: 140,
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
            child: Column(
              crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Text(Username,style: TextStyle(fontWeight: FontWeight.bold,color: isMe? Colors.black:Colors.white),),
                Text(message,style: TextStyle(color: isMe? Colors.black:Colors.white),textAlign: isMe? TextAlign.end:TextAlign.start,),
              ],
            ),
          )
        ],
      ),
      Positioned(
          top: 0,
          left: isMe? null:120,
          right: isMe? 120:null,
          child: CircleAvatar(

            backgroundImage: NetworkImage(UserImage),
          ),),

      ],


    );
  }
}
