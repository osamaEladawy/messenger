import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/features/chat/presentation/pages/chat_page.dart';
import 'package:messenger_app/view_model/chats/chats_view_model.dart';
import 'package:messenger_app/features/home_tap/ui/widgets/status_friends.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ChatsViewModel _model = ChatsViewModel();

  @override
  void dispose() {
    _model.searchName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _model.search(value);
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
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
                      onPressed: () {
                        _model.results();
                        setState(() {});
                      },
                      icon: const Icon(Icons.search),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey.shade200)),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            //StatusFriends(listOfUsers: _model.fillUsers),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverToBoxAdapter(child: const Divider()),
            //ListOfChats(listOfUsers: _model.fillUsers),
            SliverToBoxAdapter(
              child: ChatPage(
                uid: '${FirebaseAuth.instance.currentUser!.uid}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
