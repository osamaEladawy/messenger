import 'package:flutter/material.dart';
import 'package:messenger_app/view/screens/single_chat.dart';
import 'package:messenger_app/view/widgets/chat/custom_stack.dart';

import '../../../data/static/my_data.dart';

class ListOfChats extends StatelessWidget {
  const ListOfChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: dataForUsers.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SingleChat()));
              },
              leading: CustomStack(
                 backgroundImage: NetworkImage(dataForUsers[index]['image']),
                  icon: Icons.circle,
                  iconSize: 20,
                  iconColor: Colors.green,
                  onTap: () {},
                  right: -10,
                  bottom: -17),
              title:  Text(dataForUsers[index]['name']),
              subtitle: Text(dataForUsers[index]["message"]),
              trailing: IconButton(
                onPressed: () {},
                icon:  Icon(dataForUsers[index]['read']== false ? Icons.check_circle_outline : Icons.circle, color: Colors.grey.withOpacity(0.5),size: 20,),
              ),
            );
          }),
    );
  }
}
