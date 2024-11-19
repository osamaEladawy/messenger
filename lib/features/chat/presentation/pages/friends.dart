import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:messenger_app/core/const/page_const.dart';
import 'package:messenger_app/core/shared/widgets/profile_widget.dart';
import 'package:messenger_app/core/theme/style.dart';

import '../../../user/presentation/manager/get_single_user/get_single_user_cubit.dart';
import '../../../user/presentation/manager/user/user_cubit.dart';
import '../../domain/entities/message_entity.dart';

class Friends extends StatefulWidget {
  final String uid;
  const Friends({super.key, required this.uid});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  bool loading = false;

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getAllUsers();
    BlocProvider.of<GetSingleUserCubit>(context)
        .getSingleUser(userId: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, state) {
          if (state is GetSingleUserLoaded) {
            final currentUser = state.userEntity;

            return BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  final users = state.users
                      .where((user) => user.uid != widget.uid)
                      .toList();

                  if (users.isEmpty) {
                    return const Center(
                      child: Text("No Contacts Yet"),
                    );
                  }

                  return SafeArea(
                    child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PageConst.singleChatPage,
                                arguments: MessageEntity(
                                  senderUid: currentUser.uid,
                                  recipientUid: user.uid,
                                  senderName: currentUser.username,
                                  recipientName: user.username,
                                  senderProfile: currentUser.imageUrl,
                                  recipientProfile: user.imageUrl,
                                  uid: widget.uid,
                                ),
                              );
                            },
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child:
                                profileWidget(imageUrl: user.imageUrl),
                              ),
                            ),
                            title: Text("${user.username}"),
                            //subtitle: Text("${user.bio}"),
                            trailing: user.isOnline == true ?
                            Container(
                              height: 10.h,
                              width: 10.w,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                            ):Text("last seen${DateFormat.jm().format(user.dateWhenLogOut.toDate())}"),
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
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: tabColor,
            ),
          );
        },
      ),
    );
  }
}
