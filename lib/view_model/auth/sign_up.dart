import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/core/class/handel_image.dart';
import 'package:messenger_app/providers/auth_service.dart';
import 'package:messenger_app/view/auth/login.dart';
import 'package:provider/provider.dart';

class SignUpViewModel {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final myKey = GlobalKey<FormState>();
  bool isShowText = false;

  showOrHiddenText() {
    isShowText = isShowText == false ? true : false;
  }

  signUp({required BuildContext context}) async {
    if (myKey.currentState!.validate()) {
      if (password.text != confirmPassword.text) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text("passwords not match!")));
        return;
      }
      final service = Provider.of<AuthService>(context, listen: false);
      final image = Provider.of<HandleImage>(context, listen: false);
      try {
        UserCredential credential = await service.signUp(
            email: email.text,
            password: password.text,
            username: name.text,
            imageUrl: '${image.url}');

        credential.user!.sendEmailVerification();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
              ),
            ),
          );
        print(e.toString());
      }
    } else {}
  }
}
