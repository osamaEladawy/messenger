import 'package:flutter/material.dart';
import 'package:messenger_app/views/auth/login.dart';
import 'package:messenger_app/views/auth/sign_up.dart';

class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({super.key});

  @override
  State<LoginOrSignUp> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  bool isLogin = true;

  listenToAuth() {
    isLogin = !isLogin;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin == true) {
      return LoginPage(
        onTap: listenToAuth,
      );
    } else {
      return SignUp(onTap: listenToAuth);
    }
  }
}
