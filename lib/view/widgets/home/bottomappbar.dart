import 'package:flutter/material.dart';
import 'package:messenger_app/core/theme/style.dart';
import 'package:messenger_app/view_model/home/home_view_model.dart';

class CustomBottomBar extends StatefulWidget {
  final HomeViewModel model;
  const CustomBottomBar({super.key, required this.model});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return
    BottomAppBar(
      color: backGroundColor,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(widget.model.pages.length, (index) {
            return GestureDetector(
              onTap: () {
                widget.model.onChangePage(index);
                setState(() {});
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Icon(
                      widget.model.words[index]['icon'],size: 27,
                      color: widget.model.currentIndex == index
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.model.words[index]['pageName'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: widget.model.currentIndex == index
                              ? Colors.blue
                              : Colors.grey),
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
