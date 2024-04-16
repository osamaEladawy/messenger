import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/providers/auth_service.dart';
import 'package:messenger_app/providers/users_providers.dart';
import 'package:messenger_app/core/theme/style.dart';
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

  @override
  void initState() {
    _model.controller = PageController();
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
    final service = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            margin: const EdgeInsets.only(left: 10),
            child: const CircleAvatar()),
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
              color: Colors.black,
              //size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.solidEdit,
              size: 21,
              //weight: 10,
              color: Colors.black,
            ),
          ),
          IconButton(onPressed: ()async{
           await service.signOut();
          }, icon: Icon(Icons.logout))
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
