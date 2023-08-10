import 'dart:io';

import 'package:chat_app/domains/auth/domain/entities/body/sign_up_with_email_and_password_request_entity.dart';
import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/auth/bloc/photo_picker_cubit/photo_picker_cubit.dart';
import 'package:chat_app/presentation/auth/bloc/photo_picker_cubit/photo_picker_state.dart';
import 'package:chat_app/presentation/auth/bloc/sign_up_with_email_and_password_bloc/sign_up_with_email_and_password_bloc.dart';
import 'package:chat_app/presentation/auth/bloc/sign_up_with_email_and_password_bloc/sign_up_with_email_and_password_event.dart';
import 'package:chat_app/presentation/auth/bloc/sign_up_with_email_and_password_bloc/sign_up_with_email_and_password_state.dart';
import 'package:chat_app/presentation/auth/bloc/upload_photo_bloc/upload_photo_bloc.dart';
import 'package:chat_app/presentation/auth/bloc/upload_photo_bloc/upload_photo_event.dart';
import 'package:chat_app/presentation/auth/bloc/upload_photo_bloc/upload_photo_state.dart';
import 'package:chat_app/shared_libraries/component/app_bar/custom_app_bar.dart';
import 'package:chat_app/shared_libraries/component/button/custom_button.dart';
import 'package:chat_app/shared_libraries/component/dialog/custom_dialog.dart';
import 'package:chat_app/shared_libraries/component/stack/loading_stack.dart';
import 'package:chat_app/shared_libraries/component/text_field/custom_text_field.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/auth_router.dart';
import 'package:chat_app/shared_libraries/utils/resources/assets.gen.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthRouter _authRouter = sl();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signUpWithEmailAndPassword(
      {required BuildContext context, required String photoUrl}) {
    context.read<SignUpWithEmailAndPasswordBloc>().add(
          SignUpWithEmailAndPassword(
            authWithEmailAndPasswordRequestEntity:
                SignUpWithEmailAndPasswordRequestEntity(
              email: _emailController.text.trim(),
              username: _usernameController.text.trim(),
              photoUrl: photoUrl,
              password: _passwordController.text.trim(),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Create Account'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<UploadPhotoBloc, UploadPhotoState>(
            listener: (context, state) {
              final status = state.uploadPhotoState.status;

              if (status.isLoading) {
                LoadingStack.show(context);
              }
              if (status.isHasData) {
                final data = state.uploadPhotoState.data;
                data!.ref.getDownloadURL().then(
                  (photoUrl) {
                    _signUpWithEmailAndPassword(
                      context: context,
                      photoUrl: photoUrl,
                    );
                  },
                );
              }

              if (status.isError) {
                LoadingStack.dismiss(context);
                CustomDialog.show(
                  context: context,
                  type: DialogType.failed,
                  title: 'Oops!',
                  subTitle: state.uploadPhotoState.message,
                  buttonText: 'Oke',
                  onTap: () => Navigator.pop(context),
                );
              }
            },
          ),
          BlocListener<SignUpWithEmailAndPasswordBloc,
              SignUpWithEmailAndPasswordState>(
            listener: (context, state) {
              final status = state.signUpWithEmailAndPasswordState.status;
              var photo =
                  context.read<PhotoPickerCubit>().state.photoPickerState.data;

              if (status.isLoading) {
                if (photo == null) {
                  LoadingStack.show(context);
                }
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
                  subTitle: state.signUpWithEmailAndPasswordState.message,
                  buttonText: 'Oke',
                  onTap: () => Navigator.pop(context),
                );
              }
            },
          ),
        ],
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  BlocBuilder<PhotoPickerCubit, PhotoPickerState>(
                    builder: (context, state) {
                      return state.photoPickerState.observe(
                        (data) => GestureDetector(
                          onTap: () =>
                              context.read<PhotoPickerCubit>().pickPhoto(),
                          child: data == null
                              ? Assets.images.icons.account.emptyPhoto.svg(
                                  width: 124,
                                  height: 124,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    File(data.path),
                                    width: 124,
                                    height: 124,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomTextField(
                    controller: _usernameController,
                    labelText: 'Username',
                    hintText: 'Enter your username...',
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
                        var photo = context
                            .read<PhotoPickerCubit>()
                            .state
                            .photoPickerState
                            .data;
                        if (photo != null) {
                          context
                              .read<UploadPhotoBloc>()
                              .add(UploadPhoto(photo: photo));
                        } else {
                          _signUpWithEmailAndPassword(
                            context: context,
                            photoUrl: '',
                          );
                        }
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
