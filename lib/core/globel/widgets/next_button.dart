import 'package:flutter/material.dart';
import 'package:messenger_app/core/theme%20copy/style.dart';




class NextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const NextButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: tabColor,
      onPressed:onPressed,
      child:Text(text),
    );
  }
}
