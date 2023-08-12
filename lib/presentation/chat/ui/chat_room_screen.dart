import 'package:chat_app/domains/chat/domain/entities/body/create_chat_room_request_entity.dart';
import 'package:chat_app/domains/chat/domain/entities/body/send_message_request_entity.dart';
import 'package:chat_app/presentation/chat/bloc/messages_cubit/messages_cubit.dart';
import 'package:chat_app/presentation/chat/bloc/messages_cubit/messages_state.dart';
import 'package:chat_app/presentation/chat/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:chat_app/presentation/chat/bloc/send_message_bloc/send_message_event.dart';
import 'package:chat_app/presentation/user/bloc/user_by_id_cubit/user_by_id_cubit.dart';
import 'package:chat_app/presentation/user/bloc/user_by_id_cubit/user_by_id_state.dart';
import 'package:chat_app/shared_libraries/component/card/message_card.dart';
import 'package:chat_app/shared_libraries/component/item/user_item.dart';
import 'package:chat_app/shared_libraries/utils/navigation/arguments/chat_room_argument.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomScreen extends StatefulWidget {
  final ChatRoomArgument argument;
  const ChatRoomScreen({super.key, required this.argument});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _messageController = TextEditingController();

  void _getUserById() {
    context.read<UserByIdCubit>().getUserById(
          userId: widget.argument.userDataEntity.email,
        );
  }

  void _getMessages({String? chatId}) {
    context.read<MessagesCubit>().getMessages(
          chatId: widget.argument.chatId.isNotEmpty
              ? widget.argument.chatId
              : chatId!,
        );
  }

  @override
  void initState() {
    _getUserById();
    if (widget.argument.chatId.isNotEmpty) {
      _getMessages();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserByIdCubit, UserByIdState>(
        builder: (context, state) {
          return state.userByIdState.observe(
            (dataStream) => StreamBuilder(
                stream: dataStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = snapshot.data;
                  return SafeArea(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const BackButton(),
                            Expanded(
                              child: UserItem(
                                user: data!,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                showSubTitile: false,
                                photoSize: 40,
                                horizontalTitleGap: 8,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.grey.shade100,
                            child: BlocBuilder<MessagesCubit, MessagesState>(
                              builder: (context, state) {
                                return state.messagesState.observe(
                                  (messageStream) => StreamBuilder(
                                    stream: messageStream,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      final messagesData = snapshot.data;
                                      return ListView.separated(
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
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          color: ColorName.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _messageController,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText: 'Tulis pesan...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_messageController.text.isNotEmpty) {
                                    final FirebaseAuth auth =
                                        FirebaseAuth.instance;
                                    context.read<SendMessageBloc>().add(
                                          SendMessage(
                                            sendMessageRequestEntity:
                                                SendMessageRequestEntity(
                                              createChatRoomRequestEntity:
                                                  CreateChatRoomRequestEntity(
                                                participants: [
                                                  auth.currentUser!.email!,
                                                  widget.argument.userDataEntity
                                                      .email,
                                                ],
                                                lastMessage: _messageController
                                                    .text
                                                    .trim(),
                                              ),
                                              chatWith: widget.argument
                                                  .userDataEntity.email,
                                              message: _messageController.text
                                                  .trim(),
                                            ),
                                          ),
                                        );
                                    _messageController.clear();
                                  }
                                },
                                child: const Icon(
                                  Icons.send,
                                  color: ColorName.main,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
