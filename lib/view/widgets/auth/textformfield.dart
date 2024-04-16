import 'package:flutter/material.dart';
import 'package:messenger_app/core/theme/style.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final void Function()? onTap;
  final IconData? icon;
  final bool? obscureText;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.hintText,
      this.labelText,
      this.onTap,
      this.icon,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        obscureText: obscureText == null || obscureText == false ? true : false,
        validator: (value) {
          if (value!.isEmpty) {
            return "please entre this text field";
          }
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: IconButton(
            onPressed: onTap,
            icon: Icon(icon,color: obscureText == true ? buttonLoginColor:null,),
          ),
        ),
      ),
    );
  }
}
