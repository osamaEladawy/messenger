import 'package:flutter/material.dart';
import 'package:messenger_app/core/theme/style.dart';

class HaveAccountOrCreateIt extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final bool isHaveAccount;

  const HaveAccountOrCreateIt(
      {super.key,
      this.onTap,
      required this.title,
      required this.isHaveAccount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isHaveAccount
            ? const Text(
                "Already Have account ?",
                style: TextStyle(fontSize: 15),
              )
            : const Text(
                "Create Account Now",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
        TextButton(
          onPressed: onTap,
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: buttonLoginColor),
          ),
        ),
      ],
    );
  }
}
