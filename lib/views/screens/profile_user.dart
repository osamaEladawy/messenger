
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/profile_service.dart';
import '../../auth/service_auth.dart';
import '../../data/viewmodel/userprofile_model.dart';

// ignore: must_be_immutable
class UserProfilePage extends StatefulWidget {
  final QueryDocumentSnapshot doc;

  const UserProfilePage({super.key, required this.doc});
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserProfileModel userProfileModel = UserProfileModel();


  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      appBar :AppBar(
        title:  Text(userProfileModel.textAppBar),
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop(widget.doc);
            },
            icon:const Icon(Icons.arrow_back_ios)),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context)=>ProfileServise(),
        child: Consumer<ProfileServise>(
          builder: (BuildContext context, value, Widget? child)=> Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    value.pickImage(context);
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                    userProfileModel.getImageUser(widget.doc),
                  ),
                ),
                // ignore: unnecessary_null_comparison
                userProfileModel.val == null ?
                Text("${auth.name}"):
                userProfileModel.getUsers(widget.doc),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
