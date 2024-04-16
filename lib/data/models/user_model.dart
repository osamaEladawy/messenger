import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late final String? uid;
  late final String? username;
  late final String? email;
  late final String? imageUrl;
  late final bool? isOnline;

  UserModel(
      {required this.uid,
      required this.username,
      required this.email,
      required this.imageUrl,
      required this.isOnline});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final result = snapshot.data()! as Map<String, dynamic>;

    uid = result['uid'];
    username = result['username'];
    email = result['email'];
    imageUrl = result['imageUrl'];
    isOnline = result['isOnline'];
  }

  Map<String, dynamic> toJosn() => {
        "uid": uid,
        "username": username,
        "imageUrl": imageUrl,
        "email": email,
        "isOnline": isOnline
      };
}
