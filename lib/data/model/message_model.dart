import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  final String senderId;
  final String userName;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timesTamp;
  final String? date;
  final bool? unRead;
  //final String currentuser;
  //final String currentuserimage;


  factory MessageModel.fromMap(Map<String,dynamic> data){
    return MessageModel(
      senderId: data['senderId'],
      userName:data['userName'],
      senderEmail:data ['senderEmail'],
      receiverId:data ['receiverId'],
      message:data ['message'],
      timesTamp:data ['timesTamp'],
      date:data['date'],
      unRead: data['unRead'],
      //currentuser: data['currentuser'],
      //currentuserimage: data['currentuserimage'],
    );
  }

  MessageModel({required this.userName,required this.senderId, required this.senderEmail, required this.receiverId, required this.message, required this.timesTamp,required this.date,this.unRead});

  Map<String,dynamic>toJson()=>
      {'senderId':senderId,'userName':userName,'senderEmail':senderEmail,'receiverId':receiverId,'message':message,'timesTamp':timesTamp,'date':date,'unRead':unRead,};
}