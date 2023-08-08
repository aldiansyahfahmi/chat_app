import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/account/bloc/sign_out_cubit/sign_out_cubit.dart';
import 'package:chat_app/presentation/account/bloc/sign_out_cubit/sign_out_state.dart';
import 'package:chat_app/presentation/account/bloc/user_cubit/user_cubit.dart';
import 'package:chat_app/presentation/account/bloc/user_cubit/user_state.dart';
import 'package:chat_app/shared_libraries/component/account/photo.dart';
import 'package:chat_app/shared_libraries/component/app_bar/custom_app_bar.dart';
import 'package:chat_app/shared_libraries/component/button/custom_button.dart';
import 'package:chat_app/shared_libraries/component/dialog/custom_dialog.dart';
import 'package:chat_app/shared_libraries/component/stack/loading_stack.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/account_router.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final AccountRouter _accountRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Akun'),
      bottomSheet: Container(
        color: ColorName.white,
        padding: const EdgeInsets.all(16),
        child: CustomButton(
          buttonColor: ColorName.white,
          borderColor: ColorName.main,
          buttonTextColor: ColorName.main,
          buttonText: 'Keluar',
          onTap: () => CustomDialog.show(
            context: context,
            type: DialogType.custom,
            title: 'Sign Out',
            subTitle: 'Are you sure want to sign out?',
            buttonText: 'Yes',
            onTap: () => context.read<SignOutCubit>().signOut(),
          ),
        ),
      ),
      body: BlocListener<SignOutCubit, SignOutState>(
        listener: (context, state) {
          final status = state.signOutState.status;

          if (status.isLoading) {
            LoadingStack.show(context);
          }

          if (status.isHasData) {
            LoadingStack.dismiss(context);
            _accountRouter.navigateToSignInScreen();
          }

          if (status.isError) {
            LoadingStack.dismiss(context);
            CustomDialog.show(
              context: context,
              type: DialogType.failed,
              title: 'Oops!',
              subTitle: state.signOutState.message,
              buttonText: 'Oke',
              onTap: () => {},
            );
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return state.userState.observe(
              (data) => SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Photo(
                      data: data!,
                      size: 124,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      data.username,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      data.email,
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
