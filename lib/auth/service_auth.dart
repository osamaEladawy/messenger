import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/user_model.dart';

class AuthServise extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();



  bool _isSignIn = false;
  bool get isSignIn => _isSignIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _lastSeen;
  String? get lastSeen => _lastSeen;

  bool? _isActive;
  bool? get isActive => _isActive;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _provider;
  String? get provider => _provider;

  String? _uid;
  String? get uid => _uid;

  String? _name;
  String? get name => _name;

  String? _email;
  String? get email => _email;

  String? _photoUrl;
  String? get photoUrl => _photoUrl;

  bool? _image;
  bool? get image => _image;

  String? _isOnline;
  String? get isOnline => _isOnline;

  String assetImage = "assetes/images/person01.png";


  //create fun sgin in using fireAuth
  Future<UserCredential> sginINWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      _firestore.collection('users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        },
        SetOptions(merge: true),
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserModel> sginUPWithEmailAndPassword(String name,
      String email, String password,String photoUrl) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);



      _uid = userCredential.user!.uid;
      _name = userCredential.user!.displayName;
      _email = userCredential.user!.email;
      _photoUrl = userCredential.user!.photoURL;
      _provider = "email and password";

      UserModel userModel = UserModel(uid: uid, name: name, email: email, image: photoUrl, provider: provider);


      _firestore.collection('users').doc(userModel.uid).set(userModel.toJosn());


      // _firestore.collection('users').doc(uid).set({
      //  'uid':uid,
      //  'email':email,
      //  'name':name,
      //  'image':photoUrl,
      //  'provider':provider,
      // });

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //signOut
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Stream<QuerySnapshot> readAllDAta(DocumentSnapshot doc) => _firestore
      .collection('chat_rooms')
      .doc(doc.id)
      .collection('messages')
      .snapshots();

  Stream<List<UserModel>> showFavoriteUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((event) => event.docs
      .map((e) => UserModel.fromMap(
    e.data(),
  ))
      .toList());

  Stream<QuerySnapshot<Map<String, dynamic>>> showUsers() =>
      FirebaseFirestore.instance.collection('users').snapshots();
///////////////////////////////////////////////////////////////////
//////////////// Google Service //////

  sinInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    _isSignIn = preferences.getBool("signed_in") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("signed_in", true);
    _isSignIn = true;
    notifyListeners();
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        //signing to firebase user instance
        final User userDetials =
        (await _firebaseAuth.signInWithCredential(credential)).user!;

        //save to firebase user instance
        // save all values to firebase user instance
        _name = userDetials.displayName;
        _email = userDetials.email;
        _photoUrl = userDetials.photoURL;
        _uid = userDetials.uid;
        _provider = "Google";
        _isActive = ConnectionState.active.name.isNotEmpty;
        //contentEditable;
        //accessibleNode;
        // ConnectionState.active.name;
        notifyListeners();
        //-Xmx1536M
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  Future signInWithFacebook() async {
    final LoginResult result = await facebookAuth.login();
    final graphResponse = await http.get(Uri.parse(
        "https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result.accessToken!.token}'"));

    final profil = json.decode(graphResponse.body);
    if (result.status == LoginStatus.success) {
      try {
        final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token);
        await _firebaseAuth.signInWithCredential(credential);
        _name = profil['name'];
        _email = profil['email'];
        _photoUrl = profil['picture']['data']['url'];
        _uid = profil['uid'];
        _hasError = false;
        _provider = "Facebook";

        notifyListeners();
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  //get user database from firestore
  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _uid = snapshot['uid'];
      _email = snapshot['email'];
      _name = snapshot['name'];
      _photoUrl = snapshot['image'];
      _provider = snapshot['provider'];
    });
  }

  //save data to firestore
  Future saveUserDataToFirestore() async {
    final DocumentReference reference = _firestore.collection('users').doc(uid);
    reference.set({
      'uid': uid,
      'email': email,
      'name': name,
      'image': photoUrl,
      'provider': provider,
    });
    notifyListeners();
  }

  //save data to sharedpreferences
  Future saveUserDataToSharedPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("name", name!);
    await preferences.setString("image", photoUrl!);
    await preferences.setString("provider", provider!);
    await preferences.setString("uid", uid!);
    await preferences.setString("email", email!);
    notifyListeners();
  }

  Future getDataFromSharedpreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    _name = preferences.getString("name");
    _photoUrl = preferences.getString("image");
    _provider = preferences.getString("provider");
    _uid = preferences.getString("uid");
    _email = preferences.getString("email");
    notifyListeners();
  }

  //check user exists or not cloudfirestore
  Future<bool> checkUerExists() async {
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (snapshot.exists) {
      if (kDebugMode) {
        print("Existing user: ");
      }
      return true;
    } else {
      if (kDebugMode) {
        print("new user: ");
      }
      return false;
    }
  }

  //sgin out user
  Future sginOutt() async {
    await _firebaseAuth.signOut();
    await googleSignIn.signOut();
    _isSignIn = false;
    notifyListeners();
    //clear all data or storage information
    clearStoredData();
  }

  Future clearStoredData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
