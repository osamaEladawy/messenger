import 'package:flutter/material.dart';
import 'package:messenger_app/views/screens/single_chat.dart';
import 'package:messenger_app/views/widgets/chat/custom_stack.dart';

import '../../../data/static/my_data.dart';

class ActiveUsers extends StatelessWidget {
  const ActiveUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        child: ListView.separated(
          itemCount: users.length,
          itemBuilder: (context, index) {
            // QueryDocumentSnapshot result =
            // snapshot.data!.docs[index];
            // UserModel myUser = UserModel.fromSnapshot(result);

            return ListTile(
              leading: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("${users[index].imageUrl}"),
                    radius: 30,
                  ),
                  //if (myUser.isOnline == true)
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 3),
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              // : SizedBox(),
              title:
                  // users[index].isOnline == true
                  Text(users[index].username!),
              // : SizedBox(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleChat(),
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        ),
      ),
    );
  }
}
