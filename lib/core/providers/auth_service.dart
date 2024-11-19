import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/features/user/data/remote/models/user_model.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<UserModel?> getDetailsUser() async {
    if (_auth.currentUser != null) {
      User currentUser = _auth.currentUser!;
      DocumentSnapshot snapshot =
          await _store.collection("users").doc(currentUser.uid).get();

      return UserModel.fromSnapshot(snapshot);
    } else {
      print("no users details");
    }
    return null;
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String username,
    required String bio,
    String? imageUrl = '',
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String userUid = credential.user!.uid;

      final newUser = UserModel(
        uid: userUid,
        username: username,
        email: email,
        imageUrl: imageUrl,
        isOnline: false,
        dateWhenLogOut: Timestamp.now(),
        bio: bio,
        isPrivate: false,
      ).toSnapshot();

      await _store.collection('users').doc(userUid).set(newUser);

      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserCredential> login(
      {required String email, required String password}) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      "isOnline": false,
      "exitTime": Timestamp.now(),
    });

    await _auth.signOut();
  }
}
