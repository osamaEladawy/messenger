import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/views/screens/chat.dart';
import 'package:messenger_app/views/screens/people.dart';

class HomeViewModel{
PageController? controller;
 int currentIndex = 0;
 var userData = {};

 getUsers()async{
   var users = FirebaseFirestore.instance.collection("users").get().then((value){
     value.docs.forEach((element) {
       userData = element.data();
       print("userData==============================================");
       print("userDat...$userData");
       print("userData==============================================");
     });
   });
   print(users);
 }


List words= [
  {"pageName": "Chat","icon":CupertinoIcons.chat_bubble_fill,},
  {"pageName": "Group","icon":CupertinoIcons.group_solid  ,},
];

 List<Widget> pages =[
  
  const ChatPage(),
  const PeoplePage(),
];


 onChangePage(int page) {
    controller?.jumpToPage(page);
  }

 nextPage(int index){
  currentIndex = index;
 }
}