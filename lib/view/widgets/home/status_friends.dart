import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/data/models/user_model.dart';

class StatusFriends extends StatelessWidget {
  const StatusFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                          ),
                          Positioned(
                            bottom: -17,
                            right: -12,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),
                      const Text("name"),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot result =
                            snapshot.data!.docs[index];
                        UserModel myUser = UserModel.fromSnapshot(result);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                ),
                                if (myUser.isOnline == true)
                                  Positioned(
                                    bottom: 1,
                                    right: 1,
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.white, width: 3),
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Text("${myUser.username}"),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
