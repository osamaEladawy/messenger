import 'package:flutter/material.dart';

class StoriesUsers extends StatelessWidget {
  const StoriesUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
          itemBuilder: (context,index){
         return Container(
           margin: const EdgeInsets.only(right: 10),
           alignment: Alignment.centerRight,
             child: const CircleAvatar());
      }),
    );
  }
}
