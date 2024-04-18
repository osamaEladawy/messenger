import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/providers/users_providers.dart';
import 'package:messenger_app/core/theme/style.dart';
import 'package:messenger_app/view/screens/profile.dart';
import 'package:messenger_app/view/widgets/home/bottomappbar.dart';
import 'package:messenger_app/view_model/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _model = HomeViewModel();

  getUser()async{
    await _model.getUsers();
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void initState() {
    _model.controller = PageController();
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    _model.controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsersProviders>(context, listen: false).users;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>  ProfilePage(userUid: _model.userData,)));
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1594361487118-f4e2b2288aea?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGdpcmwlMjBmYWNlfGVufDB8fDB8fHww"),
            ),
          ),
        ),
        title: const Text(
          "Chat",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
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
