

import 'package:cloud_firestore/cloud_firestore.dart';


class ChatModel{

  final String? senderUid;
  final String? recipientUid;
  final String? senderName;
  final String? recipientName;
  final String? recentTextMessage;
  final Timestamp? createdAt;
  final String? senderProfile;
  final String? recipientProfile;
  final num? totalUnReadMessages;


  factory ChatModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return ChatModel(
      recentTextMessage: snap['recentTextMessage'],
      recipientName: snap['recipientName'],
      totalUnReadMessages: snap['totalUnReadMessages'],
      recipientUid: snap['recipientUid'],
      senderName: snap['senderName'],
      senderUid: snap['senderUid'],
      senderProfile: snap['senderProfile'],
      recipientProfile: snap['recipientProfile'],
      createdAt: snap['createdAt'],
    );
  }

  ChatModel({required this.senderUid, required this.recipientUid, required this.senderName, required this.recipientName, required this.recentTextMessage, required this.createdAt, required this.senderProfile, required this.recipientProfile, required this.totalUnReadMessages});

  Map<String, dynamic> toDocument() => {
    "recentTextMessage": recentTextMessage,
    "recipientName": recipientName,
    "totalUnReadMessages": totalUnReadMessages,
    "recipientUid": recipientUid,
    "senderName": senderName,
    "senderUid": senderUid,
    "senderProfile": senderProfile,
    "recipientProfile": recipientProfile,
    "createdAt": createdAt,
  };
}