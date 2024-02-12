import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/service_auth.dart';

class UserProfileImage extends StatelessWidget {
  //final DocumentSnapshot doc;
  final String imageUrl;
  final double size;

  const UserProfileImage({
    super.key, required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    // ignore: unused_element
    getImage(DocumentSnapshot doc){
      Map<String,dynamic> data = doc.data()! as Map<String,dynamic>;
      return data['image'];
    }
    return
      ClipRRect(
        borderRadius: BorderRadius.circular(size/2 -size/10),
        child:auth.photoUrl == null ? const Icon(Icons.person,size: 40,) :
        Image.network(
          imageUrl,
          width:size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
  }
}