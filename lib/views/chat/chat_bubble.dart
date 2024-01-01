import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/data/model/message_model.dart';

class ChatBubble extends StatelessWidget {
  final FirebaseAuth authCredential;
  final MessageModel messageModel;
   final String message;

  const ChatBubble({super.key, required this.message, required this.messageModel, required this.authCredential});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:messageModel.senderId == authCredential.currentUser!.uid ?  Colors.lightBlue : Colors.pink.shade400,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(message,style: const TextStyle(fontSize: 16,color: Colors.white),),
    );
  }
}