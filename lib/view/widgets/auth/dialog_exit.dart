import 'dart:io';

import 'package:flutter/material.dart';
import 'package:messenger_app/core/function/back.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Haye"),
      content: const Text("Are you sure you want to exit"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                back(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      ],
    );
  }
}
