import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:messenger/data/model/user_model.dart';
import '../../../auth/chat_service.dart';
import '../../../core/constant/custom_colors.dart';
import '../../../data/model/message_model.dart';
import '../../chat/chat_page.dart';

class MenuChat extends StatefulWidget {
  const MenuChat({super.key});
  @override
  State<MenuChat> createState() => _MenuChatState();
}

class _MenuChatState extends State<MenuChat> {
  final ChatServise _chat = ChatServise();

  List<QueryDocumentSnapshot> myMessages = [];
  List<MessageModel> msg= [];

  getMyMessage() async{
    CollectionReference reference = FirebaseFirestore.instance.collection('chat_rooms').doc(_chat.chatRoomId).collection('messages');
    QuerySnapshot data = await reference.get();
    data.docs.forEach((element) {
      return myMessages.add(element);
    });
  }

  @override
  void initState() {
   getMyMessage();
   print("${getMyMessage()}");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return
      Expanded(
        child: StreamBuilder(
          stream: _chat.readAllDAta(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              if (kDebugMode && snapshot.data != null) {
                print('this error of this menu chat');
                print(snapshot.data!.docs);
              }
              return const Text('Error');
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              if (kDebugMode && snapshot.data != null) {
                print('this loading of this menu chat');
                print("${snapshot.data!.docs}");
              }
              return const Text('Loading');
            }
            if (kDebugMode) {
              print('this success of this menu chat');
            }
            if (kDebugMode && snapshot.data != null) {
              print(snapshot.data!.docs);
            }
           print("data here");
            return Container(
              decoration: BoxDecoration(
                color: kContanerbackGround.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child:
              ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount:snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  print("data found");
                  QueryDocumentSnapshot result = snapshot.data!.docs[index];
                  Map<String,dynamic> data = result.data()! as Map<String,dynamic>;
                  MessageModel messageModel = MessageModel.fromMap(data);
                  UserModel userModel = UserModel.fromMap(data);
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap:() {
                        ChatPage(
                          reciverUserEmail: messageModel.senderEmail,
                          reciverUserId: messageModel.receiverId,
                          reciverUserName: messageModel.userName,
                        );
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: messageModel.unRead == true ? kBackGround.withOpacity(0.3) : Colors.transparent
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex:1,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: userModel.image == null ? const AssetImage("assetes/images/person01.png") :
                                  NetworkImage("${userModel.image}")as ImageProvider,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15, top: 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Text(
                                        messageModel.userName,
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.8,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        messageModel.message,
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                            letterSpacing: 0.8),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30,left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        Jiffy.parse('${messageModel.date}').fromNow(),
                                        style: const TextStyle(
                                            fontSize: 16.0, fontWeight: FontWeight.w600,
                                            color: Colors.white24),
                                      ),
                                      const SizedBox(height: 8,),
                                      messageModel.unRead == true ?
                                      Container(
                                        height: 25,
                                        width: 45,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Text(
                                            'new',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ) : const Text(''),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
  }
}



