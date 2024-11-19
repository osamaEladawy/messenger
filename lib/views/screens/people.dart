import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger_app/features/chat/presentation/pages/chat_page.dart';
import 'package:messenger_app/views/widgets/people/active_users.dart';
import 'package:messenger_app/views/widgets/people/stories_users.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  bool isActiveOrStories = false;
  int changeState = 0;

  changeStates(index) {
    changeState = index;
    if (changeState == 0) {
      changeState = index;
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => pages[index]));
    }
    print("this is $changeState");
    setState(() {});
  }

  List<Widget> pages = [
    //Center(child: Text("active")),
    const ActiveUsers(),
    const StoriesUsers(),
  ];

  selectPage(int index) {
    changeState = index;
    setState(() {});
  }

  List<String> words = [
    "Active",
    "Stories",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  words.length,
                  (index) => Container(
                    alignment: Alignment.center,
                    height: 30.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: changeState == index ? Colors.grey.shade200 : null,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        selectPage(index);
                      },
                      child: Text(
                        "${words[index]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: changeState == index
                              ? Colors.black
                              : Colors.grey.withOpacity(0.7),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          pages[changeState]
        ],
      ),
    );
  }
}
