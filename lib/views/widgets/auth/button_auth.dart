import 'package:flutter/material.dart';
import 'package:messenger_app/core/theme/style.dart';

class CustomButtonAuth extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final Color color;
  const CustomButtonAuth(
      {super.key, this.onTap, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      width: MediaQuery.of(context).size.width - 80,
      child: MaterialButton(
        shape: const StadiumBorder(),
        color: color,
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: whiteColor),
        ),
      ),
    );
  }
}
