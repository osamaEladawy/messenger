import 'package:flutter/material.dart';

class CustomAppBarHome extends StatefulWidget {
  const CustomAppBarHome({super.key});

  @override
  State<CustomAppBarHome> createState() => _CustomAppBarHomeState();
}

class _CustomAppBarHomeState extends State<CustomAppBarHome> {
  TextStyle style = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  List<String> words = ["Message", "Friends", "Groups", "Requests"];

  int currentText = 0;

  changeState(int number) {
    currentText = number;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...List.generate(
          words.length,
          (index) => GestureDetector(
            onTap: () {
              changeState(index);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: currentText == index
                    ? const Border(
                        bottom: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      )
                    : null,
              ),
              child: Text(
                words[index],
                style: style,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
