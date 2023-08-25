import 'dart:async';

import 'package:chat_app/presentation/chat/bloc/messages_cubit/messages_cubit.dart';
import 'package:chat_app/presentation/chat/bloc/messages_cubit/messages_state.dart';
import 'package:chat_app/shared_libraries/component/card/message_card.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyChatRoom extends StatelessWidget {
  BodyChatRoom({
    super.key,
  });

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey.shade100,
        child: BlocBuilder<MessagesCubit, MessagesState>(
          builder: (context, state) {
            return state.messagesState.observe(
              (messageStream) => StreamBuilder(
                stream: messageStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messagesData = snapshot.data;
                    Timer(
                        Duration.zero,
                        () => _scrollController.jumpTo(
                            _scrollController.position.maxScrollExtent));
                    return ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        final data = messagesData[index];
                        return MessageCard(
                          messageDataEntity: data,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 8.h,
                        );
                      },
                      itemCount: messagesData!.length,
                    );
                  }
                  return const SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
