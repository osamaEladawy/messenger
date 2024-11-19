import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger_app/features/user/data/remote/models/user_model.dart';
import 'package:messenger_app/features/user/domain/entities/user_entity.dart';
import 'package:messenger_app/features/user/presentation/manager/user/user_cubit.dart';

class StoriesUsers extends StatefulWidget {
  const StoriesUsers({super.key});

  @override
  State<StoriesUsers> createState() => _StoriesUsersState();
}

class _StoriesUsersState extends State<StoriesUsers> {
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
          if (users.isEmpty) {
            return Center(
              child: Text("no users available"),
            );
          }
          return Expanded(
            child: ListView.builder(
                //shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 20.w, bottom: 10.h),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${users[index].username}"),
                        SizedBox(width: 10.w),
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage:
                              NetworkImage("${users[index].imageUrl}"),
                        ),
                      ],
                    ),
                  );
                }),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
