import 'package:flutter/material.dart';
import 'package:messenger/views/auth/regester_page.dart';

import 'login_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return PageLogin(onTap: togglePages,);
    }else{
      return PageRegister(onTap: togglePages,);
    }
  }
}