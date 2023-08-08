import 'package:chat_app/presentation/chat/bloc/all_users_cubit/all_users_cubit.dart';
import 'package:chat_app/presentation/chat/bloc/all_users_cubit/all_users_state.dart';
import 'package:chat_app/shared_libraries/component/app_bar/custom_app_bar.dart';
import 'package:chat_app/shared_libraries/utils/resources/assets.gen.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'New Chat'),
      body: BlocBuilder<AllUsersCubit, AllUsersState>(
        builder: (context, state) {
          return state.allUsersState.observe(
            (data) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Assets.images.icons.account.emptyPhoto.svg(
                    height: 35.h,
                    width: 35.h,
                  ),
                  title: Text(
                    data[index].username!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 8.h,
                );
              },
              itemCount: data!.length,
            ),
          );
        },
      ),
    );
  }
}
