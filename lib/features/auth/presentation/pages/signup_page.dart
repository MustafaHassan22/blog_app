import 'package:blogapp/core/theme/app_color.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogapp/features/auth/presentation/widgets/custom_gradient_button.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign Up.",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const CustomTextFromField(hintText: 'Name'),
            const SizedBox(
              height: 15,
            ),
            const CustomTextFromField(hintText: 'Email'),
            const SizedBox(
              height: 15,
            ),
            const CustomTextFromField(hintText: 'Password'),
            const SizedBox(
              height: 25,
            ),
            const CustomGradientButton(),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: 'don\'t have an account?',
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: ' Sign In',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPallete.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
