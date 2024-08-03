import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger_app/core/class/storage_methodes.dart';
import 'package:messenger_app/core/functions/notification.dart';
import 'package:messenger_app/core/shared/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final MyNotification _notification = MyNotification();
  var data = {};
  var post = {};

  Future<String> uploadPost(String uid, File file, String description,
      String username, String profileImage, context) async {
    String res = "some error occurred";
    try {
      String photoUrl = await StorageMethod().uploadImage2("Posts", file, true);
      String postId = const Uuid().v1();

      // PostModel postModel = PostModel(
      //   uid: uid,
      //   username: username,
      //   description: description,
      //   datePublished: DateTime.now(),
      //   postId: postId,
      //   postUrl: photoUrl,
      //   profileImage: profileImage,
      //   likes: [],
      //   isSave: false,
      // );
      // _store.collection("posts").doc(postId).set(postModel.toSnapshot());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

 


  Future<void> editComment(String newText, String postId, String commentId,
      String commentUserId) async {
    var currentUser = FirebaseAuth.instance.currentUser!.uid;
    if (currentUser == commentUserId) {
      try {
        return await _store
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .update({
          "text": newText,
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> deletePost(String userId, String postId) async {
    if (FirebaseAuth.instance.currentUser!.uid == userId) {
      try {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(postId)
            .delete();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> deleteComment(
      {required String postId,
      required String commentId,
      required String commentUserId,
      required String postUserId}) async {
    var currentUser = FirebaseAuth.instance.currentUser!.uid;
    if (currentUser == commentUserId || currentUser == postUserId) {
      try {
        await _store
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .delete();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snapshot =
          await _store.collection("users").doc(uid).get();
      List following = (snapshot.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        _store.collection("users").doc(followId).update({
          "followers": FieldValue.arrayRemove([uid]),
        });
        _store.collection("users").doc(uid).update({
          "following": FieldValue.arrayRemove([followId]),
        });
      } else {
        _store.collection("users").doc(followId).update({
          "followers": FieldValue.arrayUnion([uid]),
        });
        _store.collection("users").doc(uid).update({
          "following": FieldValue.arrayUnion([followId]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  deleteSavePost(postId, context) async {
    await FirebaseFirestore.instance
        .collection("savePosts")
        .where("currentUserId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("postId", isEqualTo: postId)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        var postSave = element.data();
        String savePostId = postSave['savePostId'];

        await FirebaseFirestore.instance
            .collection("savePosts")
            .doc(savePostId)
            .delete();
      });
    });
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .update({"isSave": false}).then((value) {
      Future.delayed(const Duration(milliseconds: 3000)).then((value) {
        return showSnackBar("post unSave now", context);
      });
    });

    print("post save delete================================post");
  }

  removeMapFromFirebase(
      String documentId, Map<String, dynamic> mapToRemove) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update({
      'likes': FieldValue.arrayRemove([mapToRemove])
    });
  }

  // Future<void> shareImage(String postUrl) async {
  //   final response = await http.get(Uri.parse(postUrl));
  //   final bytes = response.bodyBytes;
  //   final temp = (await getTemporaryDirectory());
  //   final path = "${temp.path}/image.jpg";
  //  XFile file = File(path).writeAsBytesSync(bytes);
  //   await Share.shareXFiles(
  //     [file],
  //     text: "Hello users",
  //   );
  // }

  Future<void> shareImageUrl(String postUrl) async {
    const url = "https://www.youtube.com/shorts/6NGosFgx45Y";
    await Share.share(url);
  }

  Future<void> shareImageFromGalleryOrCamera() async {
    XFile? url = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (url == null) return;
    await Share.shareXFiles([url]);
    // final result = await FilePicker.platform.pickFiles(type: FileType.image);
    // final response = result?.files.map((file) => file.path).toList();
    // if(response == null) return;
    //await Share.shareFiles(response);
  }
}
