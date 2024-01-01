
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/core/service/myservice.dart';
import 'package:provider/provider.dart';

import '../../auth/chat_service.dart';
import '../../auth/service_auth.dart';

class HomeViewNodel{
  final chatService = ChatServise();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Myservice services = Myservice();

  signOut(BuildContext context){
    final authServise = Provider.of<AuthServise>(context, listen: false);
      authServise.signOut();
      print("users data deleted now..........");
  }





}