import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/chat/bloc/my_chats_cubit/my_chats_cubit.dart';
import 'package:chat_app/presentation/chat/bloc/my_chats_cubit/my_chats_state.dart';
import 'package:chat_app/shared_libraries/component/item/user_item.dart';
import 'package:chat_app/shared_libraries/utils/navigation/arguments/chat_room_argument.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/chat_router.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyChats extends StatelessWidget {
  MyChats({super.key});

  final ChatRouter _chatRouter = sl();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyChatsCubit, MyChatsState>(
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
              final chatData = snapshot.data;
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return StreamBuilder<UserDataEntity>(
                    stream: context
                        .read<MyChatsCubit>()
                        .getUsers(userId: chatData[index].chatWith),
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
                        subTitle: chatData[index].lastMessage,
                        onTap: () => _chatRouter.navigateToChatRoomScreen(
                          argument: ChatRoomArgument(
                            userDataEntity: user,
                            chatId: chatData[index].chatId,
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8.h,
                  );
                },
                itemCount: chatData!.length,
              );
            },
          ),
        );
      },
    );
  }
}
