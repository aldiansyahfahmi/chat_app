import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/chat/bloc/my_chats_cubit/my_chats_cubit.dart';
import 'package:chat_app/presentation/chat/bloc/my_chats_cubit/my_chats_state.dart';
import 'package:chat_app/presentation/user/bloc/profile_cubit/profile_cubit.dart';
import 'package:chat_app/presentation/user/bloc/profile_cubit/profile_state.dart';
import 'package:chat_app/shared_libraries/component/item/user_item.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/chat_router.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatRouter _chatRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorName.main,
        elevation: 0,
        onPressed: () => _chatRouter.navigateToNewChatScreen(),
        child: const Icon(
          Icons.chat,
          color: ColorName.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return state.profileState.observe(
                    (dataStream) => StreamBuilder(
                      stream: dataStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final data = snapshot.data;
                        return UserItem(
                          contentPadding: EdgeInsets.zero,
                          onTap: () => _chatRouter.navigateToAccountScreen(),
                          user: data!,
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'Chat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              BlocBuilder<MyChatsCubit, MyChatsState>(
                builder: (context, state) {
                  return state.myChatsState.observe(
                    (myChatStream) => StreamBuilder(
                      stream: myChatStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final data = snapshot.data;
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return StreamBuilder<UserDataEntity>(
                              stream: context
                                  .read<MyChatsCubit>()
                                  .getUsers(userId: data[index].chatWith),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final user = snapshot.data!;
                                return UserItem(
                                  contentPadding: EdgeInsets.zero,
                                  user: user,
                                  onTap: () =>
                                      _chatRouter.navigateToChatRoomScreen(
                                          userDataEntity: user),
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 8.h,
                            );
                          },
                          itemCount: data!.length,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
