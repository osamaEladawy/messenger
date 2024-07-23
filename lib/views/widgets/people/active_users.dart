import 'package:flutter/material.dart';
import 'package:messenger_app/views/screens/single_chat.dart';
import 'package:messenger_app/views/widgets/chat/custom_stack.dart';

import '../../../data/static/my_data.dart';

class ActiveUsers extends StatelessWidget {
  const ActiveUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
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
            );
          }, separatorBuilder: (BuildContext context, int index)=>const SizedBox(height: 13,),),
    );
  }
}
