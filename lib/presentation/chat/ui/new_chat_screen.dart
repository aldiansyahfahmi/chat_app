import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/user/bloc/all_users_cubit/all_users_cubit.dart';
import 'package:chat_app/presentation/user/bloc/all_users_cubit/all_users_state.dart';
import 'package:chat_app/shared_libraries/component/app_bar/custom_app_bar.dart';
import 'package:chat_app/shared_libraries/component/item/user_item.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/chat_router.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewChatScreen extends StatelessWidget {
  NewChatScreen({super.key});

  final ChatRouter _chatRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'New Chat'),
      body: BlocBuilder<AllUsersCubit, AllUsersState>(
        builder: (context, state) {
          return state.allUsersState.observe(
            (streamData) => StreamBuilder(
              stream: streamData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data!;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final user = data[index];
                    return UserItem(
                      user: user,
                      onTap: () => _chatRouter.navigateToChatRoomScreen(
                        userDataDto: user,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 8.h,
                    );
                  },
                  itemCount: data.length,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
