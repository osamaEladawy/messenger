import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/core/class/handel_image.dart';
import 'package:messenger_app/core/function/back.dart';
import 'package:messenger_app/core/theme/style.dart';
import 'package:messenger_app/providers/users_providers.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_service.dart';
import '../splash/splash_page.dart';

const style = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

class ProfilePage extends StatelessWidget {
  final Map<dynamic, dynamic> userUid;

  const ProfilePage({super.key, required this.userUid});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UsersProviders>(context).users;
    final service = Provider.of<AuthService>(context);
    final handleImage = Provider.of<HandleImage>(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  back(context);
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  size: 30,
                )),
            const SizedBox(
              width: 00,
            ),
            const Text(
              "Me",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
             await service.signOut();
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  await handleImage.updateImage(
                      context, userUid['uid'], userUid['imageUrl']);
                },
                child: CircleAvatar(
                    radius: 43,
                    backgroundImage: handleImage.profileImage(
                        true, handleImage.file, user!.imageUrl)),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Center(
              child: Text("Princes",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.bedtime,
                    color: whiteColor,
                  )),
              title: const Text(
                "Dark Mode",
                style: style,
              ),
              subtitle: const Text("Off"),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFbe2edd),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: whiteColor,
                    size: 28,
                  )),
              title: const Text(
                "Dark Mode",
                style: style,
              ),
              subtitle: const Text("Off"),
            ),
            const SizedBox(height: 15),
            ListTile(
              leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFbe2edd),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: whiteColor,
                    size: 28,
                  )),
              title: const Text(
                "Dark Mode",
                style: style,
              ),
              subtitle: const Text("Off"),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
                margin: const EdgeInsets.only(left: 26),
                child: Text(
                  "Profile",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.8)),
                )),
            const SizedBox(
              height: 12,
            ),
            ListTile(
              leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5FE369),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: whiteColor,
                    size: 28,
                  )),
              title: const Text(
                "Active Status",
                style: style,
              ),
              subtitle: const Text("Off"),
            ),
            const SizedBox(
              height: 12,
            ),
            ListTile(
              leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFff4d4d),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.wifi_tethering_error_rounded,
                    color: whiteColor,
                    size: 28,
                  )),
              title: const Text(
                "UserName",
                style: style,
              ),
              subtitle: const Text("priinces"),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
                margin: const EdgeInsets.only(left: 26),
                child: Text(
                  "Preference",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.8)),
                )),
            const SizedBox(
              height: 12,
            ),
            ListTile(
              leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFbe2edd),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: whiteColor,
                    size: 28,
                  )),
              title: const Text(
                "Privacy",
                style: style,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ListTile(
              leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFbe2edd),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: whiteColor,
                    size: 28,
                  )),
              title: const Text(
                "Avatar",
                style: style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
