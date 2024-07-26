import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/core/theme/style.dart';
import 'package:messenger_app/views/screens/profile.dart';
import 'package:messenger_app/views/widgets/home/bottomappbar.dart';
import 'package:messenger_app/view_model/home/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _model = HomeViewModel();

  // getUser() async {
  //   _model.getUsers();
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    _model.controller = PageController();
    //getUser();
    super.initState();
  }

  @override
  void dispose() {
    _model.controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  userUid: _model.userData,
                  name: '',
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, top: 7),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://t4.ftcdn.net/jpg/02/45/56/35/360_F_245563558_XH9Pe5LJI2kr7VQuzQKAjAbz9PAyejG1.jpg"),
            ),
          ),
        ),
        title: const Text(
          "Chats",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.camera_fill,
              //size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.solidEdit,
              size: 21,
            ),
          ),
        ],
      ),
      backgroundColor: backGroundColor,
      bottomNavigationBar: CustomBottomBar(
        model: _model,
      ),
      body: PageView(
        controller: _model.controller,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          _model.nextPage(value);
          setState(() {});
        },
        children: [
          ...List.generate(_model.pages.length, (index) => _model.pages[index])
        ],
      ),
    );
  }
}
