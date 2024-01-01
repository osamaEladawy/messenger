import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/model/message_model.dart';

class ChatServise extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String? date = DateTime.now().toString();
  final Timestamp timesTamp = Timestamp.now();
  String? chatRoomId;

  String? userId,otherUserId;



  Future<void>sendMessege(String receiverId,String message,String name)async{
    //get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final String currentUserName = _auth.currentUser!.displayName.toString();
    final String currentuserimage = _auth.currentUser!.photoURL.toString();
    bool? unRead = true;



    //create a new messege
    MessageModel messageModel= MessageModel(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      userName:name,
      receiverId: receiverId,
      message: message,
      timesTamp:  timesTamp,
      date: date,
      unRead: unRead,
      //currentuser: currentUserName,
      //currentuserimage:currentuserimage,
    );

    //constractor chat room id from current user id and receiver id(sorted to ensure uniqueness)
    List<String>ids=[currentUserId,receiverId];
    ids.sort();
    chatRoomId = ids.join("_");

    //add a new message to database
    await _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').add(messageModel.toJson());
  }



  //get message
  Stream<QuerySnapshot> getMessage(String userId,String otherUserId){
    List<String>ids=[userId,otherUserId];
    ids.sort();
    chatRoomId =ids.join("_");

    return _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').orderBy('timesTamp',descending: false).snapshots();
  }



  Stream<QuerySnapshot>readAllDAta(){
    return _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').snapshots();

  }

  Stream<List> showFavoriteUsers() =>
      FirebaseFirestore.instance.collection('chat_rooms').doc(chatRoomId).collection('messages').snapshots().map((event) =>
          event.docs.map((e) =>
              MessageModel.fromMap(
                e.data(),)).toList());

  Stream<QuerySnapshot<Map<String, dynamic>>>showUsers()=>FirebaseFirestore.instance.collection('messages').snapshots();




  Stream<QuerySnapshot> datas (String doc){
    var result = FirebaseFirestore.instance.collection('chat_rooms').doc(doc).collection('messages').snapshots();
    return result;
    // return null;
  }

//newMessageStream(){
  Stream<QuerySnapshot>? msg(){
    FirebaseFirestore.instance.collection('chat_rooms').doc(chatRoomId).collection('messages').snapshots();
    return null;
  }

//}



}