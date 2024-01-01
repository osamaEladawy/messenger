
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/views/screens/home_page.dart';

import 'login_or_regester.dart';

class AuthPage extends StatefulWidget {
  const  AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (conttext,snapshot){
          if(snapshot.hasData && FirebaseAuth.instance.currentUser!.emailVerified){
            return  const HomePage();
          }else{
            return const LoginOrRegister();
          }
        });
  }
}