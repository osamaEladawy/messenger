import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText, labelText;
  final TextEditingController controller;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final bool? obscureText;
  final bool? sizedField;
  final Widget? icon;
  final Widget? prefixIcon;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.obscureText,
      required this.labelText,
      this.sizedField, this.icon,
      this.onPressed,
      this.onChanged,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizedField == false || sizedField == null ? 50 : 70,
      child: TextFormField(
        onChanged: onChanged,
        validator: (value) {
          if (value!.isEmpty) {
            return "please Enter a text";
          }
        },
        controller: controller,
        obscureText: obscureText == null || obscureText == false ? false : true,
        decoration: InputDecoration(
          suffixIcon:icon,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.only(left: 20),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}
