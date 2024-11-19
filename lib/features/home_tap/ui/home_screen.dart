import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger_app/core/functions/extinctions.dart';
import 'package:messenger_app/core/functions/profile_widget.dart';
import 'package:messenger_app/core/providers/users_providers.dart';
import 'package:messenger_app/core/theme/style.dart';
import 'package:messenger_app/features/home_tap/cubit/home_tab_cubit.dart';
import 'package:messenger_app/features/user/presentation/pages/profile_page.dart';
import 'package:messenger_app/features/home_tap/ui/widgets/bottomappbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    HomeTabCubit.instance.controller = PageController();
    HomeTabCubit.instance.getUsers();
    super.initState();
  }

  @override
  void dispose() {
    HomeTabCubit.instance.controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UsersProviders>(context).users;
    return BlocConsumer<HomeTabCubit, HomeTabState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                context.push(ProfilePage(uid: "${currentUser.uid}"));
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10, top: 7),
                child: CircleAvatar(
                  backgroundImage:
                      profileImage(imageUrl: "${currentUser!.imageUrl}"),
                  //NetworkImage("${_model.userData['imageUrl']}"),
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
                icon: Icon(
                  FontAwesomeIcons.solidEdit,
                  size: 21.sp,
                ),
              ),
            ],
          ),
          backgroundColor: backGroundColor,
          bottomNavigationBar: CustomBottomBar(),
          body: PageView(
            controller: HomeTabCubit.instance.controller,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              HomeTabCubit.instance.nextPage(value);
            },
            children: [
              ...List.generate(HomeTabCubit.instance.pages.length,
                  (index) => HomeTabCubit.instance.pages[index])
            ],
          ),
        );
      },
    );
  }
}
