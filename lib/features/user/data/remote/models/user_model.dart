// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/user_entity.dart';


class UserModel extends UserEntity{
   final String? uid;
   final String? username;
   final String? email;
   final String? bio;
   final String? imageUrl;
   final bool? isOnline;
   final dateWhenLogOut;
   final bool? isPrivate;


  UserModel({required this.uid,
    required this.username,
    required this.email,
    required this.bio,
    required this.imageUrl,
    required this.isOnline,
    required this.dateWhenLogOut,
    required this.isPrivate,
  });

  Map<String, dynamic> toSnapshot() =>
      {
        "uid": uid,
        "username": username,
        "email": email,
        "bio": bio,
        "imageUrl": imageUrl,
        "isOnline":isOnline,
        "dateWhenLogOut":dateWhenLogOut,
        "isPrivate":isPrivate,
      };

 factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    var result = snapshot.data()! as Map<String, dynamic>;
  return   UserModel(
    uid : result["uid"],
    username : result["username"],
    email : result["email"],
    bio : result["bio"],
    imageUrl : result["imageUrl"],
    isOnline :result["isOnline"],
    dateWhenLogOut : result["dateWhenLogOut"],
    isPrivate : result["isPrivate"],
    );

  }
}
