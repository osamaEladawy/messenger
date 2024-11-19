import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app/features/chat/presentation/pages/chat_page.dart';
import 'package:messenger_app/my_app.dart';
import 'package:messenger_app/views/screens/people.dart';
import 'package:messenger_app/views/screens/settings.dart';

part 'home_tab_state.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  HomeTabCubit() : super(HomeTabInitial());

  static final HomeTabCubit _homeTabCubit =
      BlocProvider.of(navigatorKey.currentContext!);
  static HomeTabCubit get instance => _homeTabCubit;

  PageController? controller;
  int currentIndex = 0;
  var userData = {};

  getUsers() async {
    emit(GetDatLoading());
    try {
      var users =
          FirebaseFirestore.instance.collection("users").get().then((value) {
        value.docs.forEach((element) {
          userData = element.data();
          emit(GetDatLoaded(data: userData));
          print("userData==============================================");
          print("userDat...$userData");
          print("userData==============================================");
        });
      });
      print(users);
    } catch (e) {
      emit(GetDatFailure());
    }
  }

  List words = [
    {
      "pageName": "Chat",
      "icon": CupertinoIcons.chat_bubble_fill,
    },
    {
      "pageName": "Group",
      "icon": CupertinoIcons.group_solid,
    },
    {
      "pageName": "Settings",
      "icon": Icons.settings,
    },
  ];

  List<Widget> pages = [
    ChatPage(uid: FirebaseAuth.instance.currentUser!.uid),
    const PeoplePage(),
    const SettingsPage(),
  ];

  onChangePage(int page) {
    controller?.jumpToPage(page);
  }

  nextPage(int index) {
    currentIndex = index;
    emit(ChangeValue(value: currentIndex));
    emit(ChangeColor());
  }
}
