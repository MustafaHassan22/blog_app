// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObsecure;
  const CustomTextFromField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObsecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is empty';
        }
        return null;
      },
      controller: controller,
      obscureText: isObsecure,
      obscuringCharacter: '*',
    );
  }
}
