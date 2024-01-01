import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../../auth/chat_service.dart';
import '../../auth/service_auth.dart';
import '../../core/constant/custom_colors.dart';
import '../../data/model/message_model.dart';
import '../../data/viewmodel/regesterviewmodel.dart';
import 'chat_bubble.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  final String reciverUserEmail;
  final String reciverUserName;
  final String reciverUserId;
  final String? currentUser;

  const ChatPage({
    super.key,
    required this.reciverUserName,
    required this.reciverUserId,
    required this.reciverUserEmail,
    this.currentUser,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _toMessage = TextEditingController();
  final ChatServise _chatServise = ChatServise();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final image = RegisterViewModel();

  void sendMesssage() async {
    if (_toMessage.text.isNotEmpty) {
      await _chatServise.sendMessege(
          widget.reciverUserId, _toMessage.text, widget.reciverUserName);
      _toMessage.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackGround,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(widget.reciverUserName),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      color: kContanerbackGround,
                    ),
                    child: _buildMessagesList()),
              ),
            ),
            _buildMessagesInput(),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  //build message item
  Widget _buildMessagesItem(DocumentSnapshot doc) {
    // ignore: unused_local_variable
    final auth = Provider.of<AuthServise>(context);
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    var msgModel = MessageModel.fromMap(data);

    var alignment = (msgModel.senderId == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: (msgModel.senderId == _auth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (msgModel.senderId == _auth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Text(
                msgModel.senderId == _auth.currentUser!.uid ? "Me" : "My Friend",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ChatBubble(message: msgModel.message, messageModel: msgModel,authCredential: _auth,),
          Text(
            Jiffy.parse('${msgModel.date}').fromNow(),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

//build list
  Widget _buildMessagesList() {
    return StreamBuilder(
      stream:
          _chatServise.getMessage(_auth.currentUser!.uid, widget.reciverUserId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessagesItem(doc))
              .toList(),
        );
      },
    );
  }

  //build message input
  Widget _buildMessagesInput() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white)),
      child: Row(
        children: [
          image.handelUploadImage.file == null
              ? IconButton(
                  onPressed: () {
                    image.handelUploadImage.pickImage(context);
                  },
                  icon: const Icon(
                    Icons.photo_library,
                    size: 25,
                    color: Colors.white60,
                  ))
              : Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.file(
                    image.handelUploadImage.file!,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                  ),
                ),
          Expanded(
            child: TextField(
              style: const TextStyle(
                color: Colors.white,
                wordSpacing: 1,
              ),
              maxLines: null,
              controller: _toMessage,
              obscureText: false,
              decoration: const InputDecoration(
                hintText: 'send your message',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: sendMesssage,
            icon: const Icon(
              Icons.send,
              size: 25,
              color: Colors.blue,
            ),
            splashColor: Colors.blue.shade300,
            splashRadius: 25,
            highlightColor: Colors.yellow.shade300,
          ),
        ],
      ),
    );
  }
}
