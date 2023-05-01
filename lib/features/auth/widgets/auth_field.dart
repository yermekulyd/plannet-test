import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AuthField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Pallete.blueColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Pallete.greyColor,
              )),
          // contentPadding: EdgeInsets.all(32),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 18,
          )),
    );
  }
}
