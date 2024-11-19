import 'package:flutter/cupertino.dart';
import 'package:messenger_app/core/functions/search.dart';

class ChatsViewModel {
  TextEditingController searchName = TextEditingController();
  List fillUsers = [];
  bool isSearch = false;

  void search(String search) {
    fillUsers = searchForUser(search);
    //isSearch = true;
  }

  bool whenSearch(String value) {
    if (searchName.text.trim().isNotEmpty ||value.trim().isNotEmpty || value.trim() != "" || searchName.text.trim() != "") {
      isSearch = true;
      print("search name is " + searchName.text);
      return true;
    } else {
      isSearch = false;
         print("no search ");
      return false;
      // fillUsers = users;
    }
  }

  results(){
    if(isSearch == true){
      return fillUsers;
    }
  }


}
