import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/core/providers/users_providers.dart';
import 'package:messenger_app/features/home_tap/ui/home_screen.dart';
import 'package:messenger_app/views/auth/login_or_signup.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  getData() async {
    try {
      final service = Provider.of<UsersProviders>(context, listen: false);
      await service.refreshUsers();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              FirebaseAuth.instance.currentUser!.emailVerified) {
            return const HomeScreen();
          } else {
            return const LoginOrSignUp();
          }
        });
  }
}
