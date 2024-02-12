import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/service_auth.dart';
import '../../core/functions/handle_image.dart';
import '../../views/auth/login_page.dart';

// ignore: must_be_immutable
class RegisterViewModel {
  final String text1 = "let's create acount for you!";
  final String hint1 = 'Enter  your name';
  final String name = 'Name';
  final String hint2 = 'Enter  your email';
  final String email = 'Email';
  final String hint3 = 'Enter your password';
  final String password = 'Password';
  final String hint4 = 'Enter  your confirm Password';
  final String confirm = 'Confirm Password';
  // ignore: non_constant_identifier_names
  final String sgin_up = 'Sign-Up';
  final String ask = 'already a member ?';
  // ignore: non_constant_identifier_names
  final String Sign_In = 'Login now';

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  HandelUploadImage handelUploadImage = HandelUploadImage();
 // RegesterData regesterData = RegesterData();

  bool sizedTextField = false;
  void Function(void Function())? setState;
  bool switchState = false;
  bool hidenText = true;

  changeStatte() {
    hidenText = hidenText == true ? false : true;
  }

  whenViewImage() {
    if (handelUploadImage.file != null) {
      FileImage(File(handelUploadImage.file!.path));
    }
    if (handelUploadImage.url != null) {
      if (handelUploadImage.url!.isNotEmpty) {
        NetworkImage("${handelUploadImage.url}");
      } else {
        return null;
      }
    }
  }

  uploadImage(BuildContext context) async {
    await handelUploadImage.pickImage(context);
    if (setState != null) {
      setState!(() {});
    }
  }

  void signUp({
    required BuildContext context,
    required String toPassword,
    required String confirmPassword,
    required String toName,
    required String toEmail,
  }) async {
    if (formState.currentState!.validate() || handelUploadImage.url != null) {
      if (toPassword != confirmPassword) {
        sizedTextField = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords not match!'),
            backgroundColor: Colors.lightBlue,
          ),
        );
        return;
      }
      if ( handelUploadImage.file == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("please choose a image"),
          backgroundColor: Colors.lightBlue,
        ));
        return;
      }
      final authServise = Provider.of<AuthService>(context, listen: false);
      try {
        if (handelUploadImage.url != null) {
          await authServise.signUPWithEmailAndPassword(toName,toEmail, toPassword,handelUploadImage.url!);

        }


        FirebaseAuth.instance.currentUser!.sendEmailVerification();

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const PageLogin(),
        ));
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    } else {
      sizedTextField = true;

      if (kDebugMode) {
        print("not validate");
      }
    }
  }
}
