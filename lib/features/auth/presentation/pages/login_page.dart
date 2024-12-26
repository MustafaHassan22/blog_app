import 'package:blogapp/core/theme/app_color.dart';
import 'package:blogapp/features/auth/presentation/pages/signup_page.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogapp/features/auth/presentation/widgets/custom_gradient_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passworedController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passworedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In.",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFromField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFromField(
                hintText: 'Password',
                controller: passworedController,
                isObsecure: true,
              ),
              const SizedBox(
                height: 25,
              ),
              const CustomGradientButton(
                buttonText: 'Sign in',
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, SignupPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account?',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: ' Sign Up',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
