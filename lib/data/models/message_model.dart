

import 'package:cloud_firestore/cloud_firestore.dart';


class MessageModel{

  final String? senderUid;
  final String? recipientUid;
  final String? senderName;
  final String? recipientName;
  final String? messageType;
  final String? message;
  final Timestamp? createdAt;
  final bool? isSeen;
  final String? repliedTo;
  final String? repliedMessage;
  final String? repliedMessageType;
  final String? messageId;

  

  factory MessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return MessageModel(
      senderUid: snap['senderUid'],
      senderName: snap['senderName'],
      recipientUid: snap['recipientUid'],
      recipientName: snap['recipientName'],
      createdAt: snap['createdAt'],
      isSeen: snap['isSeen'],
      message: snap['message'],
      messageType: snap['messageType'],
      repliedMessage: snap['repliedMessage'],
      repliedTo: snap['repliedTo'],
      messageId: snap['messageId'],
      repliedMessageType: snap['repliedMessageType'],
    );
  }

  MessageModel({required this.senderUid, required this.recipientUid, required this.senderName, required this.recipientName, required this.messageType, required this.message, required this.createdAt, required this.isSeen, required this.repliedTo, required this.repliedMessage, required this.repliedMessageType, required this.messageId});

  Map<String, dynamic> toDocument() => {
    "senderUid": senderUid,
    "senderName": senderName,
    "recipientUid": recipientUid,
    "recipientName": recipientName,
    "createdAt": createdAt,
    "isSeen": isSeen,
    "message": message,
    "messageType": messageType,
    "repliedMessage": repliedMessage,
    "repliedTo": repliedTo,
    "messageId": messageId,
    "repliedMessageType": repliedMessageType,
  };
}