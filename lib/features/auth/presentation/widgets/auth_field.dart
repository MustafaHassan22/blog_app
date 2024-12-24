import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  final String hintText;
  const CustomTextFromField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
