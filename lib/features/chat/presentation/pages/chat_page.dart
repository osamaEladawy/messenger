import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:messenger_app/core/const/page_const.dart';
import 'package:messenger_app/core/functions/extinctions.dart';
import 'package:messenger_app/core/functions/profile_widget.dart';
import 'package:messenger_app/core/shared/widgets/profile_widget.dart';
import 'package:messenger_app/core/theme/style.dart';

import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../manager/chat/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  final String uid;

  const ChatPage({super.key, required this.uid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context)
        .getMyChat(chat: ChatEntity(senderUid: widget.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var service = Provider.of<HandleImage>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(),
        backgroundColor: Colors.black,
        onPressed: () {
          context.pushNamed(PageConst.friends, arguments: widget.uid);
        },
        child: const Text(
          "new Chat",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatLoaded) {
              final myChat = state.chatContacts;

              if (myChat.isEmpty) {
                return const Center(
                  child: Text("No Conversation Yet"),
                );
              }

              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: myChat.length,
                    itemBuilder: (context, index) {
                      final chat = myChat[index];
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            PageConst.singleChatPage,
                            arguments: MessageEntity(
                                senderUid: chat.senderUid,
                                recipientUid: chat.recipientUid,
                                senderName: chat.senderName,
                                recipientName: chat.recipientName,
                                senderProfile: chat.senderProfile,
                                recipientProfile: chat.recipientProfile,
                                uid: widget.uid),
                          );
                        },
                        child: ListTile(
                          leading: SizedBox(
                            child: CircleAvatar(
                              radius: 40.r,
                              // borderRadius: BorderRadius.circular(25),
                              backgroundImage:
                                  profileImage(imageUrl: chat.senderProfile),
                            ),
                          ),
                          title: Text("${chat.recipientName}"),
                          subtitle: Text(
                            "${chat.recentTextMessage}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            "last seen ${Jiffy.parse("${chat.createdAt!.toDate()}").fromNow()}",
                            //  DateFormat.jm().format(chat.createdAt!.toDate()),
                            style: TextStyle(
                              color: greyColor,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: tabColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
