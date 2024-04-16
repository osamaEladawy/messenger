import 'package:flutter/material.dart';
import 'package:messenger_app/view/widgets/chat/listofchats.dart';
import 'package:messenger_app/view/widgets/home/status_friends.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  labelText: "Search",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const StatusFriends(),
            const SizedBox(height: 20,),
            const Divider(),
            const ListOfChats(),
          ],
        ),
      ),
    );
  }
}
