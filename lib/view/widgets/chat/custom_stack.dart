import 'package:flutter/material.dart';

class CustomStack extends StatelessWidget {
  final IconData? icon;
  final void Function()? onTap;
  final double? right;
  final double? bottom;
  final Color? iconColor;
  final double? iconSize;
  final ImageProvider<Object>? backgroundImage;

  const CustomStack(
      {super.key, required this.icon, required this.onTap, required this.right, required this.bottom, this.iconColor, this.iconSize, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
         CircleAvatar(
          radius: 30,
          backgroundImage:backgroundImage,
        ),
        Positioned(
          bottom: bottom,
          right: right,
          child: IconButton(
            onPressed: onTap,
            icon: Icon(icon, color: iconColor, size: iconSize,),
          ),
        ),
      ],
    );
  }
}
