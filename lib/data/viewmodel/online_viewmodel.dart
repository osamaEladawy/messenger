import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';

class OnlineViewModel{
  bool? isSearch ;
  UserModel? userModel;
  List<UserModel> muUsers = [];
  List<QueryDocumentSnapshot> users = [];

  GlobalKey<FormState> formState = GlobalKey<FormState>();



  checkSearch(value) {
    if(value.isEmpty){
      isSearch = false;
    }
  }

  search() {
    if(formState.currentState!.validate()){
    isSearch = true;
    getUsers();
     }else{
    print("not valid");}
  }


  getUsers()async{
    final CollectionReference reference = FirebaseFirestore.instance.collection('users');
    final QuerySnapshot  snapshot = await reference.get();
    snapshot.docs.forEach((element) {
      users.add(element);

      Map<String,dynamic> data = element.data() as Map<String,dynamic>;
      userModel = UserModel.fromMap(data);
    return muUsers.add(userModel!);
    });

  }

}