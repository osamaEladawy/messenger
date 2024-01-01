import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Widget? widget;

  const MyButton({super.key, this.onTap, required this.text,  this.widget});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: MediaQuery.of(context).size.width -40,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Text(text,textAlign: TextAlign.center,style: const TextStyle(fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white),),
      ),
    );
  }
}