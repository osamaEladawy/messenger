import 'package:flutter/material.dart';
import 'package:messenger_app/features/user/data/remote/models/user_model.dart';
import 'package:messenger_app/views/screens/single_chat.dart';
import 'package:messenger_app/views/widgets/chat/custom_stack.dart';


class ListOfChats extends StatelessWidget {
  final List<UserModel> listOfUsers;
  const ListOfChats({super.key, required this.listOfUsers});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listOfUsers.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SingleChat()));
              },
              leading: CustomStack(
                backgroundImage: NetworkImage("${listOfUsers[index].imageUrl}"),
                icon: Icons.circle,
                iconSize: 20,
                iconColor: Colors.green,
                onTap: () {},
                right: -10,
                bottom: -17,
                isOnline: listOfUsers[index].isOnline,
              ),
              title: Text("${listOfUsers[index].username}"),
              subtitle: Text("message"),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  // dataForUsers[index]['read'] == false
                      // ? Icons.check_circle_outline
                       Icons.circle,
                  color: Colors.grey.withOpacity(0.5),
                  size: 20,
                ),
              ),
            );
          }),
    );
  }
}
