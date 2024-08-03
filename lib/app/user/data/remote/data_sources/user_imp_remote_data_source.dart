import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger_app/app/user/data/remote/models/user_model.dart';
import '../../../domain/entities/user_entity.dart';
import 'user_remote_data_sources.dart';

class UserImpRemoteDataSource implements UserRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore store;

  UserImpRemoteDataSource({required this.auth, required this.store});


  @override
  Future<String> getCurrentUid() async => auth.currentUser!.uid;

  @override
  Future<void> createUserEntity(UserEntity userEntity) async {
    final userCollection = store.collection("Users");

    final String uid = await getCurrentUid();

    print("new user entity Uid == $uid");
    final newUser = UserModel(
            uid: uid,
            username: userEntity.username,
            email: userEntity.email,
            bio: userEntity.bio,
            imageUrl: userEntity.imageUrl,
            isOnline: userEntity.isOnline,
            dateWhenLogOut: userEntity.dateWhenLogOut,
            isPrivate: userEntity.isPrivate)
        .toSnapshot();
    try {
      userCollection.doc(uid).get().then((docUser) {
        if (!docUser.exists) {
          userCollection.doc(uid).set(newUser);
         
        }else {
          //userCollection.doc(uid).update(newUser);

        }
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollection = store.collection("users");
    return userCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }


  @override
  Stream<List<UserEntity>> getSingleUserUid(String userUid) {
    final userCollection = store
        .collection("users")
        .where("uid", isEqualTo: userUid);
    return userCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;



  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> updateUserEntity(UserEntity userEntity) async {
    final userCollection = store.collection("users");

    Map<String, dynamic> info = {};

    if (userEntity.username != "" && userEntity.username != null)
      info['userName'] = userEntity.username;

    if (userEntity.bio != "" && userEntity.bio != null)
      info['userName'] = userEntity.bio;

    if (userEntity.imageUrl != "" && userEntity.imageUrl != null)
      info['profileUrl'] = userEntity.imageUrl;

    if (userEntity.isOnline != null) info['isOnline'] = userEntity.isOnline;

    userCollection.doc(userEntity.uid).update(info);
  }

}
