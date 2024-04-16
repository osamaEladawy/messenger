import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/view/chat.dart';
import 'package:messenger_app/view/people.dart';

class HomeViewModel{
PageController? controller;
 int currentIndex = 0;


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