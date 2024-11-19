import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger_app/features/chat/data/remote/models/chat_model.dart';
import 'package:messenger_app/features/chat/data/remote/models/message_model.dart';

class FireStoreMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  createChats(
      {required String recipientName,
      required String recipientUid,
      required String senderName,
      required String recentTextMessage,
      required String senderProfile,
      required String recipientProfile,
      required num totalUnReadMessages}) async {
    try {
      final collectionRef = _store
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("chats");

      final newChat = ChatModel(
              senderUid: _auth.currentUser!.uid,
              recipientUid: recipientUid,
              senderName: senderName,
              recipientName: recipientName,
              recentTextMessage: recentTextMessage,
              createdAt: Timestamp.now(),
              senderProfile: senderProfile,
              recipientProfile: recipientProfile,
              totalUnReadMessages: totalUnReadMessages)
          .toDocument();

        await  collectionRef.doc(recipientUid).set(newChat);
    } catch (e) {}
  }

  createMessage(
      {required String recipientUid,
      required String senderName,
      required String recipientName,
      required String messageType,
      required String message,
      required bool isSeen,
      required String repliedTo,
      required String repliedMessage,
      required String repliedMessageType}) async {
    try {
      String currentUserUid = _auth.currentUser!.uid;
      final collectionRef = _store
          .collection("users")
          .doc(currentUserUid)
          .collection("chats")
          .doc(recipientUid)
          .collection("messages");

      String messageId = collectionRef.doc().id;

      final newMessage = MessageModel(
              senderUid: currentUserUid,
              recipientUid: recipientUid,
              senderName: senderName,
              recipientName: recipientName,
              messageType: messageType,
              message: message,
              createdAt: Timestamp.now(),
              isSeen: false,
              repliedTo: repliedTo,
              repliedMessage: repliedMessage,
              repliedMessageType: repliedMessageType,
              messageId: messageId)
          .toDocument();

     await collectionRef.doc(messageId).set(newMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
