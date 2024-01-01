import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/profile_service.dart';
import '../../auth/service_auth.dart';

class UserProfileModel{
  String textAppBar = "Profile";

  final ProfileServise serviseProfile = ProfileServise();
  bool val = false ;


  getData(BuildContext context)async{
    final auth = Provider.of<AuthServise>(context,listen: false);
    await auth.getDataFromSharedpreferences();
  }

  getImageUser(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data()! as Map<String,dynamic>;
    if(data['image'] != null){
      return  NetworkImage('${data['image']}');
    }
    return const AssetImage("assetes/images/person01.png");
  }


  getUsers(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data()! as Map<String,dynamic>;
    return Column(
      children: [
        if(data['name'] != null) Text(data["name"]),
      ],
    );
  }



}