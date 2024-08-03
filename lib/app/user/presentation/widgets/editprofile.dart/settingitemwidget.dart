import 'package:flutter/material.dart';
import 'package:messenger_app/core/theme%20copy/style.dart';

class SettingsItemWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final IconData? icon;
  final VoidCallback? onTap;
  const SettingsItemWidget(
      {super.key, this.title, this.description, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
              width: 80,
              height: 80,
              child: Icon(
                icon,
                color: greyColor,
                size: 25,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "$description",
                  style: const TextStyle(fontSize: 17),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
