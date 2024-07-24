import 'package:flutter/material.dart';
import 'package:messenger_app/data/static/my_data.dart';

class StoriesUsers extends StatelessWidget {
  const StoriesUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: 20, bottom: 10),
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 33,
                    backgroundImage: NetworkImage("${users[index].imageUrl}"),
                  ),
                  // const SizedBox(width: 10,),
                  // Text("${users[index].username}"),
                ],
              ),
            );
          }),
    );
  }
}
