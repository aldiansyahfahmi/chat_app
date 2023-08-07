import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/shared_libraries/component/button/custom_button.dart';
import 'package:chat_app/shared_libraries/component/text_field/custom_text_field.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/auth_router.dart';
import 'package:chat_app/shared_libraries/utils/resources/assets.gen.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final AuthRouter _authRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: ColorName.white,
        padding: const EdgeInsets.all(24),
        child: GestureDetector(
          onTap: () => _authRouter.navigateToSignUpScreen(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dont have any account? ',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorName.main,
                ),
              ),
            ],
          ),
        ),
      ),
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
                'Sign In to Continue',
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
                buttonText: 'Sign In',
                onTap: () => {},
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorName.main,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                'OR',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorName.main,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: Assets.images.icons.auth.google.svg(),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorName.main,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: Assets.images.icons.auth.facebook.svg(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
