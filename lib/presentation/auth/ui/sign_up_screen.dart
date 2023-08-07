import 'package:chat_app/domains/auth/domain/entities/body/sign_up_with_email_and_password_request_entity.dart';
import 'package:chat_app/presentation/auth/bloc/sign_up_with_email_and_password_bloc/sign_up_with_email_and_password_bloc.dart';
import 'package:chat_app/presentation/auth/bloc/sign_up_with_email_and_password_bloc/sign_up_with_email_and_password_event.dart';
import 'package:chat_app/presentation/auth/bloc/sign_up_with_email_and_password_bloc/sign_up_with_email_and_password_state.dart';
import 'package:chat_app/shared_libraries/component/app_bar/custom_app_bar.dart';
import 'package:chat_app/shared_libraries/component/button/custom_button.dart';
import 'package:chat_app/shared_libraries/component/dialog/custom_dialog.dart';
import 'package:chat_app/shared_libraries/component/stack/loading_stack.dart';
import 'package:chat_app/shared_libraries/component/text_field/custom_text_field.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      body: BlocListener<SignUpWithEmailAndPasswordBloc,
          SignUpWithEmailAndPasswordState>(
        listener: (context, state) {
          final status = state.signUpWithEmailAndPasswordState.status;
          if (status.isLoading) {
            LoadingStack.show(context);
          }

          if (status.isHasData) {
            LoadingStack.dismiss(context);
            CustomDialog.show(
              context: context,
              type: DialogType.success,
              title: 'Yeah!',
              subTitle: 'Sign Up successful, Please sign in to continue.',
              buttonText: 'Oke',
              onTap: () => Navigator.pop(context),
              onDismissible: () => Navigator.pop(context),
            );
          }

          if (status.isError) {
            LoadingStack.dismiss(context);
            CustomDialog.show(
              context: context,
              type: DialogType.failed,
              title: 'Oops!',
              subTitle: state.signUpWithEmailAndPasswordState.message,
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
                    'Create Account',
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
                    buttonText: 'Sign Up',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignUpWithEmailAndPasswordBloc>().add(
                              SignUpWithEmailAndPassword(
                                signUpWithEmailAndPasswordRequestEntity:
                                    SignUpWithEmailAndPasswordRequestEntity(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                ),
                              ),
                            );
                      }
                    },
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
