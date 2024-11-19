import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger_app/core/const/page_const.dart';
import 'package:messenger_app/core/functions/extinctions.dart';
import 'package:messenger_app/core/functions/profile_widget.dart';
import 'package:messenger_app/features/user/domain/entities/user_entity.dart';
import 'package:messenger_app/features/user/presentation/manager/user/user_cubit.dart';
import 'package:messenger_app/views/screens/single_chat.dart';

class ActiveUsers extends StatefulWidget {
  const ActiveUsers({super.key});

  @override
  State<ActiveUsers> createState() => _ActiveUsersState();
}

class _ActiveUsersState extends State<ActiveUsers> {
  @override
  void initState() {
    UserCubit.instance.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserLoaded) {
          List<UserEntity> users = state.users;
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              //height: 80,
              child: ListView.separated(
                // shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  // QueryDocumentSnapshot result =
                  // snapshot.data!.docs[index];
                  // UserModel myUser = UserModel.fromSnapshot(result);

                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(PageConst.singleChatPage);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundImage: profileImage(
                                  imageUrl: "${users[index].imageUrl}"),
                              radius: 30.r,
                            ),
                            if (users[index].isOnline == true)
                              Positioned(
                                bottom: -7.h,
                                right: 1.w,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.h),
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                        color: Colors.white, width: 3.w),
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: 10.w),
                        Text('${users[index].username}'),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
