import 'package:chat_app/shared_libraries/component/app_bar/custom_app_bar.dart';
import 'package:chat_app/shared_libraries/component/button/custom_button.dart';
import 'package:chat_app/shared_libraries/component/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Chat App',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              const CustomTextField(
                labelText: 'Email',
                hintText: 'Enter your email...',
              ),
              SizedBox(
                height: 16.h,
              ),
              const CustomTextField(
                obscureText: true,
                labelText: 'Password',
                hintText: 'Enter your password...',
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomButton(
                buttonText: 'Sign Up',
                onTap: () => {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
