
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/core/service/myservice.dart';
import 'package:provider/provider.dart';

import '../../auth/chat_service.dart';
import '../../auth/service_auth.dart';

class HomeViewModel{
  final chatService = ChatService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Myservice services = Myservice();

  signOut(BuildContext context){
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
      print("users data deleted now..........");
  }





}