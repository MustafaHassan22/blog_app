import 'package:blogapp/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final String buttonText;
  const CustomGradientButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          )),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width, 65),
            backgroundColor: AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          )),
    );
  }
}
