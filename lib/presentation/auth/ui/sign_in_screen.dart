import 'package:chat_app/domains/auth/domain/entities/body/auth_with_email_and_password_request_entity.dart';
import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/auth/bloc/sign_in_with_email_and_password_bloc/sign_in_with_email_and_password_bloc.dart';
import 'package:chat_app/presentation/auth/bloc/sign_in_with_email_and_password_bloc/sign_in_with_email_and_password_event.dart';
import 'package:chat_app/presentation/auth/bloc/sign_in_with_email_and_password_bloc/sign_in_with_email_and_password_state.dart';
import 'package:chat_app/shared_libraries/component/button/custom_button.dart';
import 'package:chat_app/shared_libraries/component/dialog/custom_dialog.dart';
import 'package:chat_app/shared_libraries/component/stack/loading_stack.dart';
import 'package:chat_app/shared_libraries/component/text_field/custom_text_field.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/auth_router.dart';
import 'package:chat_app/shared_libraries/utils/resources/assets.gen.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final AuthRouter _authRouter = sl();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
      body: BlocListener<SignInWithEmailAndPasswordBloc,
          SignInWithEmailAndPasswordState>(
        listener: (context, state) {
          final status = state.signInWithEmailAndPasswordState.status;
          if (status.isLoading) {
            LoadingStack.show(context);
          }

          if (status.isHasData) {
            LoadingStack.dismiss(context);
            _authRouter.navigateToChatScreen();
          }

          if (status.isError) {
            LoadingStack.dismiss(context);
            CustomDialog.show(
              context: context,
              type: DialogType.failed,
              title: 'Oops!',
              subTitle: state.signInWithEmailAndPasswordState.message,
              buttonText: 'Oke',
              onTap: () => Navigator.pop(context),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
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
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Enter your email...',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Can not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    obscureText: true,
                    labelText: 'Password',
                    hintText: 'Enter your password...',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Can not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomButton(
                    buttonText: 'Sign In',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignInWithEmailAndPasswordBloc>().add(
                              SignInWithEmailAndPassword(
                                authWithEmailAndPasswordRequestEntity:
                                    AuthWithEmailAndPasswordRequestEntity(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                ),
                              ),
                            );
                      }
                    },
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
        ),
      ),
    );
  }
}
