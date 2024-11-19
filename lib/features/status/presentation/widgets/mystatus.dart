import 'package:flutter/material.dart';
import 'package:messenger_app/core/class/handel_image.dart';
import 'package:messenger_app/core/functions/extinctions.dart';
import 'package:messenger_app/core/theme/style.dart';
import 'package:provider/provider.dart';

import '../../../../../core/const/page_const.dart';

class MyStatusOfRow extends StatelessWidget {
  const MyStatusOfRow({super.key});

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<HandleImage>(context);
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 27,
              backgroundImage: service.profileImage(false),
            ),
            Positioned(
              bottom: -1,
              right: -1,
              child: SizedBox(
                height: 24,
                width: 24,
                child: FloatingActionButton.small(
                  backgroundColor: whiteColor,
                  elevation: 0,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: blackColor,
                      width: 2,
                    ),
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.add_circle,
                    color: tabColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 12,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("MyStatus"),
            Text("tab to add your status update"),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            context.pushNamed(PageConst.myStatusPage);
          },
          icon: Icon(
            Icons.more_horiz,
            color: greyColor.withOpacity(.5),
          ),
        ),
      ],
    );
  }
}
