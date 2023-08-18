import 'package:chat_app/domains/chat/domain/entities/body/create_chat_room_request_entity.dart';
import 'package:chat_app/domains/chat/domain/entities/body/send_message_request_entity.dart';
import 'package:chat_app/presentation/chat/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:chat_app/presentation/chat/bloc/send_message_bloc/send_message_event.dart';
import 'package:chat_app/shared_libraries/utils/navigation/arguments/chat_room_argument.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FooterChatRoom extends StatelessWidget {
  final ChatRoomArgument argument;
  FooterChatRoom({super.key, required this.argument});

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                final FirebaseAuth auth = FirebaseAuth.instance;
                context.read<SendMessageBloc>().add(
                      SendMessage(
                        sendMessageRequestEntity: SendMessageRequestEntity(
                          createChatRoomRequestEntity:
                              CreateChatRoomRequestEntity(
                            participants: [
                              auth.currentUser!.email!,
                              argument.userDataEntity.email,
                            ],
                            lastMessage: _messageController.text.trim(),
                          ),
                          chatWith: argument.userDataEntity.email,
                          message: _messageController.text.trim(),
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
    );
  }
}
