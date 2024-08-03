import 'package:flutter/material.dart';
import 'package:messenger_app/app/user/domain/entities/user_entity.dart';
import 'package:messenger_app/view_model/profile/profile_view_model.dart';

class DetialesForUser extends StatefulWidget {
  final ProfileViewModel model;
  final UserEntity userEntity;
  final String uid;

  const DetialesForUser(
      {super.key,
      required this.model,
      required this.userEntity,
      required this.uid});

  @override
  State<DetialesForUser> createState() => _DetialesForUserState();
}

class _DetialesForUserState extends State<DetialesForUser> {
  Column buildContentColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.model.userData['imageUrl'] != null)
          CircleAvatar(
            radius: 35,
            backgroundImage:
                NetworkImage("${widget.model.userData['imageUrl']}"),
          ),
      ],
    );
  }
}
