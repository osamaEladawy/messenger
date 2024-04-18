import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late final String? uid;
  late final String? username;
  late final String? email;
  late final String? imageUrl;
  late final bool? isOnline;
  late final  exitTime;

  UserModel(
      {required this.uid,
      required this.username,
      required this.email,
      required this.imageUrl,
      required this.isOnline,
      required this.exitTime,
      });

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final result = snapshot.data()! as Map<String, dynamic>;

    uid = result['uid'];
    username = result['username'];
    email = result['email'];
    imageUrl = result['imageUrl'];
    isOnline = result['isOnline'];
    exitTime = result['exitTime'];
  }

  Map<String, dynamic> toJosn() => {
        "uid": uid,
        "username": username,
        "imageUrl": imageUrl,
        "email": email,
        "isOnline": isOnline,
        "exitTime": exitTime
      };
}
