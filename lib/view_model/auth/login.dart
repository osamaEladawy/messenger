import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/core/const/page_const.dart';
import 'package:messenger_app/core/functions/extinctions.dart';
import 'package:messenger_app/core/providers/auth_service.dart';
import 'package:messenger_app/views/auth/initial_page.dart';
import 'package:provider/provider.dart';

class LoginViewModel {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final myKey = GlobalKey<FormState>();
  bool isShowText = false;
  bool isCheck = false;

  showOrHiddenText() {
    isShowText = isShowText == false ? true : false;
  }

  Future login({required BuildContext context}) async {
    final service = Provider.of<AuthService>(context, listen: false);
    try {
      await service
          .login(email: email.text, password: password.text)
          .then((value) async {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .update({
          "isOnline": true,
        });
        FirebaseMessaging.instance.subscribeToTopic("users");
        FirebaseMessaging.instance.subscribeToTopic("users$userId");
        print("userid===============================================");
        print("userId login $userId");
        print("userid===============================================");

      context.pushNamedAndRemoveUntil(PageConst.initialPage);
           
      });
    } catch (e) {
       AwesomeDialog(
           dialogType: DialogType.error,
          context: context,
          title: "Welcome",
          desc: "This is not correct email or password").show();
       print(e.toString());
    }
  }

  forgetPassword({required BuildContext context}) async {
    if (email.text.isEmpty || email.text == "") {
       AwesomeDialog(
           dialogType: DialogType.noHeader,
          context: context,
          title: "Welcome",
          desc: "Please Enter your email and try again ").show();
      return;
    } else {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
         AwesomeDialog(
             dialogType: DialogType.success,
             context: context,
            title: "Welcome",
            desc: "Please check your email ").show();
      } catch (e) {
         AwesomeDialog(
             dialogType: DialogType.error,
             context: context,
            title: "Welcome",
            desc: "This is not correct email").show();
      }
    }
  }
}
