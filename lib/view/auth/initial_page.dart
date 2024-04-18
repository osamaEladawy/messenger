import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/providers/users_providers.dart';
import 'package:messenger_app/view/auth/login_or_signup.dart';
import 'package:messenger_app/view/screens/home.dart';
import 'package:provider/provider.dart'; 

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

 getData()async{
  final service = Provider.of<UsersProviders>(context,listen: false);
  await service.refreshUsers();
 }


 @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
      if(snapshot.hasData && FirebaseAuth.instance.currentUser!.emailVerified){
      return const HomePage();
      }else{
     return const LoginOrSignUp();
      }
    });
  }
}