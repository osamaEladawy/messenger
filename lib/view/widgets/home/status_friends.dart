import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/core/class/handle_request.dart';
import 'package:messenger_app/data/models/user_model.dart';
import 'package:messenger_app/data/static/my_data.dart';

class StatusFriends extends StatelessWidget {
  const StatusFriends({super.key});

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1594361487118-f4e2b2288aea?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGdpcmwlMjBmYWNlfGVufDB8fDB8fHww"),
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
              const Text("me"),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Row(
            children: [
              SizedBox(
                height: 80,
                width: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: dataForUsers.length,
                  itemBuilder: (context, index) {
                    // QueryDocumentSnapshot result =
                    // snapshot.data!.docs[index];
                    // UserModel myUser = UserModel.fromSnapshot(result);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(dataForUsers[index]['image']),
                              radius: 30,
                            ),
                            //if (myUser.isOnline == true)
                            Positioned(
                              bottom: 1,
                              right: 1,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text("${dataForUsers[index]['name']}"),
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
        ],
      ),
    );
    // StreamBuilder(
    //   stream: FirebaseFirestore.instance.collection("users").snapshots(),
    //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //
    //     if (snapshot.hasData) {
    //       return ;
    //     }
    //     return const CircularProgressIndicator();
    //   });
  }
}
