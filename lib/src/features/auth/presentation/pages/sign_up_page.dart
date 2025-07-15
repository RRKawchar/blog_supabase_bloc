import 'package:blog_app/src/core/theme/app_colors.dart';
import 'package:blog_app/src/core/widgets/custom_textfiled.dart';
import 'package:blog_app/src/core/widgets/k_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            SizedBox(height: 30),

            CustomTextFiled(hintText: "Name"),
            SizedBox(height: 15),
            CustomTextFiled(hintText: "Email"),

            SizedBox(height: 15),
            CustomTextFiled(hintText: "Password", isObscure: true),
            SizedBox(height: 20),

            KButton(
              onPressed: (){},
              text: "Sign up",
            ),

            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
              },
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        color: AppColors.buttonColor,
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
    );
  }
}
