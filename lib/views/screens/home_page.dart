import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/constant/custom_colors.dart';
import '../../data/viewmodel/home_viewmodel.dart';
import '../widgets/home/categories.dart';
import '../widgets/home/fav_users.dart';
import '../widgets/home/menu_chat.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var view = HomeViewNodel();
    return StatefulBuilder(
      builder:
          (BuildContext context, void Function(void Function()) setState) =>
              Scaffold(
        backgroundColor: kBackGround,
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                )),
            title: const Text(
              "Chats",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    view.signOut(context);
                    setState(() {});
                  },
                  icon: const Icon(Icons.logout)),
            ]),
        body: WillPopScope(
          onWillPop: () {
            showDialog(
              barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text(
                        "Haye!",
                        textAlign: TextAlign.center,
                      ),
                      content: const Text(
                        "Are You Log Out App?",textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).maybePop();
                                },
                                child: const Text("No")),
                            ElevatedButton(
                                onPressed: () {
                                  exit(0);
                                },
                                child: const Text("Yes")),
                          ],
                        ),
                      ],
                    ));
            return Future.value(false);
          },
          child: const SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                CateegoriesSelector(),
                SizedBox(
                  height: 10,
                ),
                FavoriteCateegories(),
                SizedBox(
                  height: 10,
                ),
                MenuChat(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
