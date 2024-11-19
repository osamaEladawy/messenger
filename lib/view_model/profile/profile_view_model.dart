import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:messenger_app/core/class/handel_image.dart';
import 'package:messenger_app/core/providers/auth_service.dart';
import 'package:messenger_app/core/storage/pref_services.dart';
import 'package:provider/provider.dart';

import '../../core/shared/snackbar.dart';

class ProfileViewModel {
  var data = {};
  var post = {};
  var userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollow = false;
  bool loading = false;
  String postId = '';
  late Timestamp time;
  bool value = false;

  logOut(context) async {
    var service = Provider.of<AuthService>(context, listen: false);
   // if (PrefServices.getData(key:"uid") != null) {
      try {
        //String userId = PrefServices.getData(key:"uid")!;
        FirebaseMessaging.instance.unsubscribeFromTopic("users");
        FirebaseMessaging.instance.unsubscribeFromTopic("users${FirebaseAuth.instance.currentUser?.uid}");
        //PrefServices.sharedPreferences!.clear();
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .update({
          "isOnline": false,
          "dateWhenLogOut": DateTime.now(),
        });
        await service.signOut();
        print("============================================");
        print("${FirebaseAuth.instance.currentUser?.uid}   logOut");
        print("============================================");
      } catch (e) {
        showSnackBar(e.toString(), context);
      }
    // } else {
    //   showSnackBar("no user save", context);
    // }
  }

  privateMyProfile(uid) async {
    value = !value;
    if (value) {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "isPrivate": true,
      });
    } else {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "isPrivate": false,
      });
    }
  }

  getPosts() async {
   try{
     await FirebaseFirestore.instance.collection("posts").get().then((value) {
      for (var element in value.docs) {
        post = element.data();
        print("post=============================post");
        print(post);
        print("post=============================post");
      }
    });
   }catch(e){
    //throw Exception(e.toString());
   }
  }

  getData(context, String uid) async {
    loading = true;
    try {
      var userSnap =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      var snapPost = await FirebaseFirestore.instance
          .collection("posts")
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLength = snapPost.docs.length;

      userData = userSnap.data()!;
      print("================================================");
      print(userData);
      print("================================================");
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollow = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    loading = false;
  }

  changePhoto({context, uid, imageUrl}) async {
    var service = Provider.of<HandleImage>(context, listen: false);
    await service.updateImage(context, uid, imageUrl);
  }
}
