import 'package:flutter/material.dart';
import 'package:messenger_app/view/single_chat.dart';
import 'package:messenger_app/view/widgets/chat/custom_stack.dart';

class ListOfChats extends StatelessWidget {
  const ListOfChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: 40,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SingleChat()));
              },
              leading: CustomStack(
                  icon: Icons.circle,
                  iconSize: 20,
                  iconColor: Colors.green,
                  onTap: () {},
                  right: -10,
                  bottom: -17),
              title: const Text("username"),
              subtitle: const Text("message"),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check_circle_outline),
              ),
            );
          }),
    );
  }
}
